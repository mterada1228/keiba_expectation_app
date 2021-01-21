module Scraper
  # RaceResultモデルのスクレイピングを実施
  # Usage: Scraper::RaceResultScraperService.new(url: <データ取得先URL>).call
  # netkeiba の レースデータベースからデータを取得
  # （URL例）https://db.netkeiba.com/race/202044110310/
  class RaceResultScraperService
    attr_reader :url, :driver

    TIMEOUT = 4

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
      race_id: ->(elements) { %r{/race/(\w+)/\z}.match(elements[:url])[1] },
      course_condition: lambda do |elements|
        RaceResult::
        COURSE_CONDITION_TRANSLATIONS[/: (\S+)/.match(elements[:race_info].text.split('/')[2])[1]]
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
        return nil unless entire_rap(elements)

        entire_rap(elements).slice(0..2).sum / entire_rap(elements).reverse.slice(0..2).sum * 50
      end,
      horse_all_number: ->(elements) { elements[:horses_list].size - 1 }
    }.freeze

    class << self
      def entire_rap(elements)
        return nil unless elements[:rap_time_info]

        course_length = /\d+/.match(elements[:race_info].text.split('/')[0])[0]
        entire_rap = elements[:rap_time_info].text.split('-').map(&:to_f)
        return entire_rap if (course_length.to_i % 200).zero?

        entire_rap[0] = entire_rap[0] * 200 / (course_length.to_i % 200)
        entire_rap
      end
    end

    def parse
      driver.get(url)

      attributes = {}
      OPERATOR.each_key do |column_name|
        attributes[column_name] = OPERATOR[column_name].call elements
      end
      attributes
    end

    # rubocop:disable Layout/LineLength
    def elements
      @elements |= {
        url: url,
        race_info: driver.find_element(:css, '#main > div > div > div > diary_snap > div > div > dl > dd > p > diary_snap_cut > span'),
        rap_time_info: begin
          driver.find_element(:css, '#contents > div.result_info.box_left > table:nth-child(4) > tbody > tr:nth-child(1) > td')
        rescue Selenium::WebDriver::Error::NoSuchElementError
          nil
        end,
        horses_list: driver.find_element(css: '#contents_liquid > table > tbody').find_elements(:tag_name, 'tr')
      }
    end
    # rubocop:enable Layout/LineLength

    def create(attributes)
      # 参照元クラス Race のデータ取得
      race_id = %r{/race/(\w+)/\z}.match(url)[1]
      race_scrape(race_id) unless RaceResult.exists?(race_id)

      race_result = RaceResult.find_or_initialize_by(id: attributes[:id])
      race_result.update_attributes!(attributes)
    end

    def race_scrape(race_id)
      race_url = "https://race.netkeiba.com/race/shutuba.html?race_id=#{race_id}"
      # 海外競馬の場合
      return Scraper::RaceAbroadScraperService.new(url: race_url).call if race_id.slice(4) == 'C'

      Scraper::RaceScraperService.new(url: race_url).call
    end
  end
end
