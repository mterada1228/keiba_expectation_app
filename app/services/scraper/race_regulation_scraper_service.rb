module Scraper
  class RaceRegulationScraperService
    attr_reader :elements

    def initialize(elements:)
      @elements = elements
      ActiveRecord::Base.logger = Logger.new($stdout)
    end

    def call
      create
    end

    private

    def create
      race_regulation_list.each do |attributes|
        race_regulation = RaceRegulation.find_or_initialize_by(race_id: attributes[:race_id],
                                                               regulation: attributes[:regulation])
        race_regulation.update_attributes!(attributes)
      end
    end

    def race_regulation_list
      race_id = /race_id=(\d+)/.match(elements[:url])[1]
      regulations_and_prizes.map do |regulation|
        if RaceRegulation::REGULATION_TRANSLATIONS.keys.include?(regulation)
          { race_id: race_id, regulation: RaceRegulation::REGULATION_TRANSLATIONS[regulation] }
        end
      end.compact
    end

    def regulations_and_prizes
      elements[:regulations_and_prizes].text
        .gsub(/[\( \) \[ \]]/, "\n")
        .gsub('特指', "特\n指").split(/\n/)
    end
  end
end
