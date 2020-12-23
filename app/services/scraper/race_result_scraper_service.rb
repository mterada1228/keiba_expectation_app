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
      id: ->(elements) { %r{/race/(\d+)/\z}.match(elements[:url])[1] },
      name: ->(elements) { elements[:name].text },
      course_id: ->(elements) { %r{/race/(\d+)/\z}.match(elements[:url])[1].slice(4..5) },
      course_length: ->(elements) { /\d+/.match(elements[:race_info].text.split('/')[0])[0] },
      date: ->(elements) { elements[:date].text.split[0].gsub(/[年, 月, 日]/, '/') },
      course_type: lambda do |elements|
        RaceResult::COURSE_TYPE_TRANSLATIONS[elements[:race_info].text.split('/')[0].slice(0).to_s]
      end,
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
      prize: ->(elements) { elements[:prize].text.delete(',') },
      horse_all_number: ->(elements) { elements[:horses_list].size - 1 }
    }.freeze

    class << self
      def entire_rap(elements)
        return nil unless elements[:rap_time_info]

        course_length = /\d+/.match(elements[:race_info].text.split('/')[0])[0]
        entire_rap = elements[:rap_time_info].text.split('-').map(&:to_f)
        return entire_rap if (course_length.to_i % 200).zero?

        entire_rap[0] = entire_rap[0] * 200 / course_length.to_i % 200
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
      {
        url: url,
        name: driver.find_element(:css, '#main > div > div > div > diary_snap > div > div > dl > dd > h1'),
        date: driver.find_element(:css, '#main > div > div > div > diary_snap > div > div > p'),
        race_info: driver.find_element(:css, '#main > div > div > div > diary_snap > div > div > dl > dd > p > diary_snap_cut > span'),
        prize: driver.find_element(:css, '#contents_liquid > table > tbody > tr:nth-child(2) > td:nth-child(21)'),
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
      race_result = RaceResult.find_or_initialize_by(id: attributes[:id])
      race_result.update_attributes!(attributes)
    end
  end
end
