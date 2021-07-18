module Scraper
  # HorseRaceモデルのスクレイピングを実施
  # Usage: Scraper::HorseRaceScraperService.new(url: <データ取得先URL>).call
  # netkeiba の 競走馬データベースからデータを取得
  # （URL例）https://db.netkeiba.com/horse/2018104963
  class HorseRaceScraperService # rubocop:disable Metrics/ClassLength
    def initialize(url:)
      @url = url
    end

    def call
      Rails.logger.info("#{self.class}.#{__method__} start")
      response = HTTParty.get(@url)
      create(parse(response))
      Rails.logger.info("#{self.class}.#{__method__} end")
    end

    private

    OPERATOR = {
      horse_id: ->(elements) { %r{horse/(\d+)}.match(elements[:url])[1] },
      race_id: lambda do |elements|
        %r{race/(.+)/\z}.match(elements[:race_result_link].first.attributes['href'].value)[1]
      end,
      gate_number: lambda do |elements|
        elements[:gate_number].text.presence
      end,
      horse_number: ->(elements) { elements[:horse_number].text },
      odds: ->(elements) { elements[:odds].text },
      popularity: ->(elements) { elements[:popularity].text },
      order_of_arrival: lambda do |elements|
        return if /\A[除 中 取]+\z/.match elements[:order_of_arrival].text

        elements[:order_of_arrival].text
      end,
      jockey: ->(elements) { elements[:jockey].text.gsub(/\n/, '') },
      burden_weight: ->(elements) { elements[:burden_weight].text },
      time: lambda do |elements|
        elements[:time].text.present? ? "0:#{elements[:time].text}" : nil
      end,
      time_diff: lambda do |elements|
        elements[:time_diff].text.presence
      end,
      passing_order: lambda do |elements|
        elements[:passing_order].text.presence
      end,
      last_3f: lambda do |elements|
        elements[:last_3f].text.presence
      end,
      horse_weight: lambda do |elements|
        return if elements[:horse_weight].text == '計不'

        /(\d+)\((.+)\)/.match(elements[:horse_weight].text)[1]
      end,
      difference_in_horse_weight: lambda do |elements|
        return if elements[:horse_weight].text == '計不'

        /(\d+)\((.+)\)/.match(elements[:horse_weight].text)[2]
      end,
      get_prize: lambda do |elements|
        elements[:get_prize].text.present? ? elements[:get_prize].text.delete(',') : nil
      end,
      reason_of_exclusion: lambda do |elements|
        case elements[:order_of_arrival].text
        when '中'
          HorseRace.reason_of_exclusions[:pull_up]
        when '除'
          HorseRace.reason_of_exclusions[:scratch]
        when '取'
          HorseRace.reason_of_exclusions[:withdrawn]
        end
      end
    }.freeze

    def parse(response)
      doc = Nokogiri::HTML(response)

      race_results = doc.css('div.db_main_race.fc > div > table > tbody > tr')

      race_results.map do |race_result|
        attributes = {}
        elements = elements(race_result)
        OPERATOR.each do |column, operation|
          attributes[column] = operation.call elements
        end
        attributes
      end
    end

    def elements(race_result) # rubocop:disable Metrics/MethodLength
      {
        url: @url,
        race_result_link: race_result.css('td:nth-child(5) > a'),
        gate_number: race_result.css('td:nth-child(8)'),
        horse_number: race_result.css('td:nth-child(9)'),
        odds: race_result.css('td:nth-child(10)'),
        popularity: race_result.css('td:nth-child(11)'),
        order_of_arrival: race_result.css('td:nth-child(12)'),
        jockey: race_result.css('td:nth-child(13)'),
        burden_weight: race_result.css('td:nth-child(14)'),
        time: race_result.css('td:nth-child(18)'),
        time_diff: race_result.css('td:nth-child(19)'),
        passing_order: race_result.css('td:nth-child(21)'),
        last_3f: race_result.css('td:nth-child(23)'),
        horse_weight: race_result.css('td:nth-child(24)'),
        get_prize: race_result.css('td:nth-child(28)')
      }
    end

    def create(attributes_list)
      attributes_list.map do |attributes|
        # 参照元クラス Race のデータ取得
        race_scrape(attributes[:race_id]) unless Race.exists?(attributes[:race_id])

        # 参照元クラス Horse のデータ取得
        unless Horse.exists?(attributes[:horse_id])
          horse_url = "https://db.netkeiba.com/horse/#{attributes[:horse_id]}/"
          HorseScraperService.new(url: horse_url).call
        end

        # HorseRaceのデータ保存
        horse_race = HorseRace.find_or_initialize_by(horse_id: attributes[:horse_id],
                                                     race_id: attributes[:race_id])
        horse_race.update_attributes!(attributes)
      end
    end

    def race_scrape(race_id)
      race_url = "https://race.netkeiba.com/race/shutuba.html?race_id=#{race_id}"
      # 海外競馬の場合
      return Scraper::RaceAbroadScraperService.new(url: race_url).call if race_id.slice(4) == 'C'

      Scraper::RaceScraperService.new(url: race_url).call
    end
  end
end
