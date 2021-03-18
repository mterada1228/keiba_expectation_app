module Scraper
  class Parser
    class << self
      def parse_horse(response)
        document = Nokogiri::HTML(response)

        item = Horse.new
        item[:id] = %r{horse/(\d+)}.match(response.request.path.to_s)[1]
        item[:name] =
          document.css('#db_main_box > div.db_head.fc > div.db_head_name.fc > div.horse_title > h1')
                  .text.gsub(/[[:space:]]/, '')
        item
      end
    end
  end
end
