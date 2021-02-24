module Scraper
  # HorseRaceモデルのスクレイピングを実施
  # Usage: Scraper::HorseRaceFromRacePageScraperService.new(url: <データ取得先URL>).call
  # netkeiba の レースページからデータを取得
  # （URL例）https://race.netkeiba.com/race/shutuba.html?race_id=202105010809
  class HorseRaceFromRacePageScraperService # rubocop:disable Metrics/ClassLength
    attr_reader :url, :driver

    TIMEOUT = 60

    def initialize(url:)
      @url = url
      setup
      ActiveRecord::Base.logger = Logger.new($stdout)
    end

    def setup
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      @driver = Selenium::WebDriver.for :chrome, options: options
      @driver.manage.timeouts.implicit_wait = TIMEOUT
    end

    def call
      create(parse)
    end

    private

    OPERATOR = {
      horse_id: ->(elements) { %r{horse/(\d+)}.match(elements[:horse_url].attribute('href'))[1] },
      race_id: ->(elements) { /race_id=(\d+)/.match(elements[:race_url])[1] },
      gate_number: lambda do |elements|
        elements[:gate_number].text.present? ? elements[:gate_number].text : nil
      end,
      horse_number: lambda do |elements|
        elements[:horse_number].text.present? ? elements[:horse_number].text : nil
      end,
      odds: ->(elements) { elements[:odds].text },
      popularity: ->(elements) { elements[:popularity].text },
      jockey: ->(elements) { elements[:jockey].text.gsub(/\n/, '') },
      burden_weight: ->(elements) { elements[:burden_weight].text },
      horse_weight: lambda do |elements|
        return nil if elements[:horse_weight].text == '計不' || elements[:horse_weight].text.blank?

        /(\d+)\((.+)\)/.match(elements[:horse_weight].text)[1]
      end,
      difference_in_horse_weight: lambda do |elements|
        return nil if elements[:horse_weight].text == '計不' || elements[:horse_weight].text.blank?

        /(\d+)\((.+)\)/.match(elements[:horse_weight].text)[2]
      end,
    }.freeze

    def parse
      driver.get(url)

      horse_races =
        driver.find_elements(:css,
                             '#page > div.RaceColumn02 > div.RaceTableArea > table > tbody > tr')
      horse_races.map do |horse_race|
        attributes = {}
        elements = elements(horse_race)
        OPERATOR.each_key do |column_name|
          attributes[column_name] = OPERATOR[column_name].call elements
        end
        attributes
      end
    end

    # rubocop:disable Metrics/MethodLength
    def elements(horse_race)
      {
        horse_url: horse_race.find_element(:css, 'td.HorseInfo > div > div > span > a'),
        race_url: url,
        gate_number: horse_race.find_element(:css, 'td.Waku.Txt_C'),
        horse_number: horse_race.find_element(:css, 'td.Umaban.Txt_C'),
        odds: horse_race.find_element(:css, 'td.Popular'),
        popularity: horse_race.find_element(:css, 'td.Popular_Ninki'),
        jockey: horse_race.find_element(:css, 'td.Jockey'),
        burden_weight: horse_race.find_element(:css, 'td:nth-child(6)'),
        horse_weight: horse_race.find_element(:css, 'td.Weight')
      }
    end
    # rubocop:enable Metrics/MethodLength

    def create(attributes_list)
      attributes_list.map do |attributes|
        # 参照元クラス Horse のデータ取得
        unless Horse.exists?(attributes[:horse_id])
          horse_url = "https://db.netkeiba.com/horse/#{attributes[:horse_id]}/"
          Scraper::HorseScraperService.new(url: horse_url).call
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
