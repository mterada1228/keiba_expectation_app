module Scraper
  # RaceResultモデルのスクレイピングを実施
  # Usage: Scraper::RaceResultScraperService.new(url: <データ取得先URL>).call
  # netkeiba の レースデータベースからデータを取得
  # （URL例）https://db.netkeiba.com/race/202044110310/
  class RaceResultScraperService
    attr_reader :url, :timeout, :wait_time

    def initialize(url:)
      @url = url
      @wait_time = 3
      @timeout = 4
      ActiveRecord::Base.logger = Logger.new($stdout)
    end

    def call
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      driver = Selenium::WebDriver.for :chrome, options: options
      driver.manage.timeouts.implicit_wait = timeout
      create(parse(driver))
    end

    private

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def parse(driver)
      driver.get(url)

      data_intro = driver.find_element(:class, 'data_intro')
      span_in_data_intro = data_intro.find_element(:tag_name, 'span').text.split('/')

      course_length = /\d+/.match(span_in_data_intro[0])[0]
      entire_rap = begin
        driver.find_element(:class, 'race_lap_cell').text.split('-').map(&:to_f)
      rescue Selenium::WebDriver::Error::NoSuchElementError
        nil
      end
      first_half_ave_3f = first_half_ave_3f(course_length, entire_rap)
      last_half_ave_3f = last_half_ave_3f(course_length, entire_rap)

      {
        id: %r{/race/(\d+)/\z}.match(url)[1],
        name: data_intro.find_element(:tag_name, 'h1').text,
        course_id: %r{/race/(\d+)/\z}.match(url)[1].slice(4..5),
        course_length: course_length,
        date: data_intro.find_element(:class, 'smalltxt').text.split[0].gsub(/[年,月,日]/, '/'),
        course_type: RaceResult::
          COURSE_TYPE_TRANSLATIONS[span_in_data_intro[0].slice(0).to_s],
        course_condition: RaceResult::
          COURSE_CONDITION_TRANSLATIONS[/: (\S+)/.match(span_in_data_intro[2])[1]],
        entire_rap: entire_rap,
        ave_1F: ave_1f(course_length, entire_rap),
        first_half_ave_3F: first_half_ave_3f(course_length, entire_rap),
        last_half_ave_3F: last_half_ave_3f(course_length, entire_rap),
        RPCI: rpci(first_half_ave_3f, last_half_ave_3f),
        prize: driver.find_element(
          css: '#contents_liquid > table > tbody > tr:nth-child(2) > td:nth-child(21)'
        ).text.delete(','),
        horse_all_number: driver
          .find_element(css: '#contents_liquid > table > tbody')
          .find_elements(:tag_name, 'tr').size - 1
      }
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

    def create(attribute)
      race_result = RaceResult.find_or_initialize_by(id: attribute[:id])
      race_result.update_attributes!(attribute)
    end

    def ave_1f(course_length, entire_rap)
      return nil unless entire_rap

      entire_rap = correct_lap_time_when_running_200m(course_length, entire_rap)
      entire_rap.sum / entire_rap.size if course_length.to_i % 200
    end

    def first_half_ave_3f(course_length, entire_rap)
      return nil unless entire_rap

      entire_rap = correct_lap_time_when_running_200m(course_length, entire_rap)
      entire_rap.slice(0..2).sum
    end

    def last_half_ave_3f(course_length, entire_rap)
      return nil unless entire_rap

      entire_rap = correct_lap_time_when_running_200m(course_length, entire_rap)
      entire_rap.reverse.slice(0..2).sum
    end

    def rpci(first_half_ave_3f, last_half_ave_3f)
      return nil unless first_half_ave_3f && last_half_ave_3f

      first_half_ave_3f / last_half_ave_3f * 50
    end

    def correct_lap_time_when_running_200m(course_length, entire_rap)
      return entire_rap if (course_length.to_i % 200).zero?

      entire_rap[0] = entire_rap[0] * 200 / course_length.to_i % 200
      entire_rap
    end
  end
end
