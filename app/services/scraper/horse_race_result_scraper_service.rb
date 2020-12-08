module Scraper
  # HorseRaceResultモデルのスクレイピングを実施
  # Usage: Scraper::HorseRaceResultScraperService.new(url: <データ取得先URL>).call
  # netkeiba の 競走馬データベースからデータを取得
  # （URL例）https://db.netkeiba.com/horse/2016104458/
  class HorseRaceResultScraperService
    attr_reader :url

    def initialize(url:)
      @url = url
      ActiveRecord::Base.logger = Logger.new($stdout)
    end

    def call
      response = HTTParty.get(url)
      create(parse(response))
    end

    private

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def parse(response)
      url = response.request.path.to_s
      doc = Nokogiri::HTML(response)

      race_results = doc.css('div.db_main_race.fc > div > table > tbody > tr')

      race_results.map do |race_result|
        {
          horse_id: %r{horse/(\d+)}.match(url)[1],
          race_result_id: %r{race/(.+)/\z}
            .match(race_result.children[9].children[0].attributes['href'].value)[1],
          gate_number: gate_number(race_result),
          horse_number: race_result.children[17].text,
          odds: race_result.children[19].text,
          popularity: race_result.children[21].text,
          order_of_arrival: order_of_arrival(race_result),
          jockey: race_result.children[25].children[1].attributes['title'].value,
          burden_weight: race_result.children[27].text,
          time: time(race_result),
          time_diff: time_diff(race_result),
          passing_order: passing_order(race_result),
          last_3f: last_3f(race_result),
          horse_weight: horse_weight(race_result),
          difference_in_horse_weight: difference_in_horse_weight(race_result),
          get_prize: get_prize(race_result),
          reason_of_exclusion: reason_of_exclusion(race_result)
        }
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

    def create(attributes)
      attributes.map do |attribute|
        # 参照元クラス RaceResult のデータ取得
        unless RaceResult.exists?(attribute[:race_result_id])
          race_result_url = "https://db.netkeiba.com/race/#{attribute[:race_result_id]}/"
          Scraper::RaceResultScraperService.new(url: race_result_url).call
        end

        # 参照元クラス Horse のデータ取得
        unless Horse.exists?(attribute[:horse_id])
          horse_url = "https://db.netkeiba.com/horse/#{attribute[:horse_id]}/"
          Scraper::HorseScraperService.new(url: horse_url).call
        end

        # HorseRaceResultのデータ保存
        horse_race_result = HorseRaceResult
                            .find_or_initialize_by(horse_id: attribute[:horse_id],
                                                   race_result_id: attribute[:race_result_id])
        horse_race_result.update_attributes!(attribute)
      end
    end

    def gate_number(race_result)
      return nil if race_result.children[15].text.blank?

      race_result.children[15].text
    end

    def order_of_arrival(race_result)
      return nil if /\A[除 中 取]+\z/.match race_result.children[23].text

      race_result.children[23].text
    end

    def time(race_result)
      return nil if race_result.children[35].text.blank?

      "0:#{race_result.children[35].text}"
    end

    def time_diff(race_result)
      return nil if race_result.children[37].text.blank?

      race_result.children[37].text
    end

    def passing_order(race_result)
      return nil if race_result.children[41].text.blank?

      race_result.children[41].text
    end

    def last_3f(race_result)
      return nil if race_result.children[45].text.blank?

      race_result.children[45].text
    end

    def horse_weight(race_result)
      return nil if race_result.children[47].text == '計不'

      /(\d+)\((.+)\)/.match(race_result.children[47].text)[1]
    end

    def difference_in_horse_weight(race_result)
      return nil if race_result.children[47].text == '計不'

      /(\d+)\((.+)\)/.match(race_result.children[47].text)[2]
    end

    def get_prize(race_result)
      return nil if race_result.children[55].text.blank?

      race_result.children[55].text
    end

    def reason_of_exclusion(race_result)
      case race_result.children[23].text
      when '中'
        HorseRaceResult.reason_of_exclusions[:pull_up]
      when '除'
        HorseRaceResult.reason_of_exclusions[:scratch]
      when '取'
        HorseRaceResult.reason_of_exclusions[:withdrawn]
      end
    end
  end
end
