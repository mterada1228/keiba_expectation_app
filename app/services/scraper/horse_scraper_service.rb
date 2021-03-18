module Scraper
  # Horseモデルのスクレイピングを実施
  # Usage: Scraper::HorseScraperService.new(url: <データ取得先URL>).call
  # netkeiba の 競走馬データベースからデータを取得
  # （URL例）https://db.netkeiba.com/horse/2016104458/
  class HorseScraperService
    def initialize(url:)
      @url = url
    end

    def call
      Rails.logger.info("#{self.class}.#{__method__} start")
      response = HTTParty.get(@url)
      horse = Scraper::Parser.parse_horse(response)
      Scraper::Creator.create(horse)
      Rails.logger.info("#{self.class}.#{__method__} end")
    end
  end
end
