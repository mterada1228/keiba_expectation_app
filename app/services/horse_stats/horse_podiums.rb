module HorseStats
  # @param  [Array<HorseRace>]
  class HorsePodiums
    def initialize(horse_races)
      @horse_races = horse_races
    end

    def first_place
      @first_place ||= by_place[1].try(:count) || 0
    end

    def second_place
      @second_place ||= by_place[2].try(:count) || 0
    end

    def third_place
      @third_place ||= by_place[3].try(:count) || 0
    end

    def unplaced
      @unplaced ||= unplaced_horse_races(by_place).try(:count) || 0
    end

    private

    def by_place
      @by_place ||= @horse_races.group_by(&:order_of_arrival)
    end

    def unplaced_horse_races(by_place)
      by_place.select do |order_of_arrival, _horse_races|
        order_of_arrival >= 4
      end.values.flatten
    end
  end
end
