module Scraper
  # Horseモデルのスクレイピングを実施
  # Usage: Scraper::HorseScraperService.new(url: <データ取得先URL>).call
  # netkeiba の 競走馬データベースからデータを取得
  # （URL例）https://db.netkeiba.com/horse/2016104458/
  class HorseScraperService
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

    def parse(response)
      url = response.request.path.to_s
      doc = Nokogiri::HTML(response)
      {
        id: %r{horse/(\d+)}.match(url)[1],
        name: doc
          .css('#db_main_box > div.db_head.fc > div.db_head_name.fc > div.horse_title > h1')
          .text.gsub(/[[:space:]]/, '')
      }
    end

    def create(attributes)
      horse = Horse.find_or_initialize_by(id: attributes[:id])
      horse.update_attributes!(attributes)
    end
  end
end
