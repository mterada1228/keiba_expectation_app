module Scraper
  # netkeibaのトップページよりスクレイピングを行い、各モデルのデータ取得を行う。
  # Usage: Scraper::TopPageScraperService.new.call
  refine Selenium::WebDriver::Element do
    def href
      find_element(css: 'a').attribute('href')
    end
  end

  class TopPageScraperService
    using Scraper

    TIMEOUT = 60
    NETKEIBA_TOP_URL = 'https://race.netkeiba.com/top/?rf=navi'.freeze

    def initialize
      @url = NETKEIBA_TOP_URL
      setup
    end

    def call
      Rails.logger.info("#{self.class}.#{__method__} start")
      parse
      Rails.logger.info("#{self.class}.#{__method__} end")
    end

    private

    def setup
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      @driver = Selenium::WebDriver.for :chrome, options: options
      @driver.manage.timeouts.implicit_wait = TIMEOUT
    end

    def parse
      @driver.get(@url)
      urls = @driver.find_elements(css: '#date_list_sub > li').map(&:href)
      urls.each do |url|
        if past_date?(url)
          create_past_race_data(url)
        else
          create_future_race_data(url)
        end
      end
    end

    def past_date?(url)
      Date.parse(/kaisai_date=(\d+)/.match(url)[1]) < Date.today
    end

    def create_past_race_data(url)
      @driver.get(url)
      @driver.find_elements(:class_name, 'RaceList_DataItem').each do |list|
        Scraper::RaceResultFromRaceTabScraperService.new(url: list.href).call
      end
    end

    def create_future_race_data(url)
      @driver.get(url)
      @driver.find_elements(:class_name, 'RaceList_DataItem').each do |list|
        Scraper::RaceScraperService.new(url: list.href).call
        Scraper::HorseRaceFromRacePageScraperService.new(url: list.href).call
      end
    end
  end
end
