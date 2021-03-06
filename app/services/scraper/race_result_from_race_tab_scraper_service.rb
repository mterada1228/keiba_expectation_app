module Scraper
  # Raceモデルのスクレイピングを実施
  # Usage: Scraper::RaceResultFromRaceTabScraperService.new(url: <データ取得先URL>).call
  # netkeiba の レース からデータを取得
  # （URL例）https://race.netkeiba.com/race/result.html?race_id=202105010611

  class RaceResultFromRaceTabScraperService
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
      id: ->(elements) { /race_id=(\w+)/.match(elements[:url])[1] },
      course_condition: lambda do |elements|
        Race::
        COURSE_CONDITION_TRANSLATIONS[/:(\S+)/.match(elements[:race_info].text.split('/')[3])[1]]
      end,
      entire_rap: ->(elements) { entire_rap(elements) },
      ave_1F: lambda do |elements|
        entire_rap(elements) ? entire_rap(elements).sum / entire_rap(elements).size : nil
      end,
      first_half_ave_3F: lambda do |elements|
        entire_rap(elements) ? entire_rap(elements).slice(0..2).sum : nil
      end,
      last_half_ave_3F: lambda do |elements|
        entire_rap(elements) ? entire_rap(elements).reverse.slice(0..2).sum : nil
      end,
      RPCI: lambda do |elements|
        return unless entire_rap(elements)

        entire_rap(elements).slice(0..2).sum / entire_rap(elements).reverse.slice(0..2).sum * 50
      end,
      horse_all_number: ->(elements) { elements[:horses_list].count }
    }.freeze

    class << self
      def entire_rap(elements)
        return if elements[:rap_time_info].blank?

        course_length = /\d+/.match(elements[:race_info].text.split('/')[1])[0]
        entire_rap = elements[:rap_time_info].map { |rap| rap.text.to_f }
        return entire_rap if (course_length.to_i % 200).zero?

        entire_rap[0] = entire_rap[0] * 200 / (course_length.to_i % 200)
        entire_rap
      end
    end

    def parse(response)
      doc = Nokogiri::HTML(response)
      elements = elements(doc)
      attributes = {}
      OPERATOR.each do |column, operation|
        attributes[column] = operation.call elements
      end
      attributes
    end

    def elements(doc)
      {
        url: @url,
        race_info: doc.css('#page > div.RaceColumn01 > div > div.RaceMainColumn > ' \
                           'div.RaceList_NameBox > div.RaceList_Item02 > div.RaceData01'),
        rap_time_info: doc.css('#tab_ResultSelect_1_con > div.Result_Pay_Back.mb5 > ' \
                               'div.ResultPayback.Block_Inline > div.Table_Scroll > ' \
                               'table > tbody > tr:nth-child(3) > td'),
        horses_list: doc.css('#All_Result_Table > tbody > tr')
      }
    end

    def create(attributes)
      # 参照元クラス Race のデータ取得
      id = /race_id=(\w+)/.match(@url)[1]
      race_scrape(id) unless Race.exists?(id)

      race_result = Race.find_or_initialize_by(id: attributes[:id])
      attributes[:has_result] = true
      race_result.update_attributes!(attributes)
      Rails.logger.info(attributes)
    end

    def race_scrape(id)
      race_url = "https://race.netkeiba.com/race/shutuba.html?race_id=#{id}"
      # 海外競馬の場合
      return Scraper::RaceAbroadScraperService.new(url: race_url).call if id.slice(4) == 'C'

      Scraper::RaceScraperService.new(url: race_url).call
    end
  end
end
