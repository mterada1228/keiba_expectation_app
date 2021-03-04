module Scraper
  class RaceRegulationScraperService
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
      race_regulation_list.each do |attributes|
        race_regulation = RaceRegulation.find_or_initialize_by(race_id: attributes[:race_id],
                                                               regulation: attributes[:regulation])
        race_regulation.update_attributes!(attributes)
        Rails.logger.info(attributes)
      end
    end

    def race_regulation_list
      race_id = /race_id=(\d+)/.match(@elements[:url])[1]
      regulations_and_prizes.map do |regulation|
        if RaceRegulation::REGULATION_TRANSLATIONS.keys.include?(regulation)
          { race_id: race_id, regulation: RaceRegulation::REGULATION_TRANSLATIONS[regulation] }
        end
      end.compact
    end

    def regulations_and_prizes
      @elements[:regulations_and_prizes]
        .text.gsub(/[( ) \[ \]]/, "\n").gsub('特指', "特\n指").split(/\n/)
    end
  end
end
