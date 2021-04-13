module Scraper
  class HorseUpserter
    def initialize(attributes:)
      @attributes = attributes
    end

    def call
      horse = Horse.find_or_initialize_by(id: @attributes[:id])
      horse.update!(@attributes)
    end
  end
end
