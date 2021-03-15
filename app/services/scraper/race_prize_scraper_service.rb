module Scraper
  class RacePrizeScraperService
    def initialize(elements:)
      @elements = elements
    end

    def call
      Rails.logger.info("#{self.class}.#{__method__} start")
      create
      Rails.logger.info("#{self.class}.#{__method__} end")
    end

    private

    def create
      race_prizes_list.each do |attributes|
        race_prize = RacePrize
                     .find_or_initialize_by(race_id: attributes[:race_id],
                                            order_of_arrival: attributes[:order_of_arrival])
        race_prize.update_attributes!(attributes)
        Rails.logger.info(attributes)
      end
    end

    def race_prizes_list
      race_id = /race_id=(\d+)/.match(@elements[:url])[1]
      prizes.map.with_index(1) do |prize, order_of_arrival|
        {
          race_id: race_id,
          order_of_arrival: order_of_arrival,
          prize: prize
        }
      end
    end

    def prizes
      /本賞金:(.*)万円/.match(@elements[:regulations_and_prizes].text)[1].split(',')
    end
  end
end
