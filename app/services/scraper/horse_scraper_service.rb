module Scraper
  # Horseモデルのスクレイピングを実施
  # Usage: Scraper::HorseScraperService.new(<データ取得先URL>)
  # netkeiba の 競走馬データベースからデータを取得
  # （URL例）https://db.netkeiba.com/horse/2016104458/
  class HorseScraperService
    attr_reader :url

    def initialize(url:)
      @url = url
      ActiveRecord::Base.logger = Logger.new($stdout)
    end

    def call
      html = HTTParty.get(url)
      create(parse(html))
    end

    private

    def parse(html)
      url = html.request.path.to_s
      doc = Nokogiri::HTML(html)

      {
        id: /\d+$/.match(url)[0],
        name: doc.css('div.horse_title > h1').children[0].text.gsub(/[[:space:]]/, '')
      }
    end

    def create(attribute)
      horse = Horse.find_or_initialize_by(id: attribute[:id])
      horse.update_attributes!(attribute)
    end
  end
end
