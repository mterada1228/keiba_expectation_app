module Scraper
  class HorseScraper
    def initialize(url:)
      @url = url
    end

    def call
      response = HTTParty.get(@url)
      document = Nokogiri::HTML(response)

      item = {}
      item[:id] = %r{horse/(\d+)}.match(response.request.path.to_s)[1]
      item[:name] =
        document.css('#db_main_box > div.db_head.fc > div.db_head_name.fc > div.horse_title > h1')
                .text.gsub(/[[:space:]]/, '')
      item
    end
  end
end
