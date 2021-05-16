module HorseStats
  class HorsePodiums
    attr_reader :first_place, :second_place, :third_place, :unplaced

    def initialize(horse_races)
      horse_races_by_place = horse_races.group_by(&:order_of_arrival)
      @first_place = horse_races_by_place[1].try(:count) || 0
      @second_place = horse_races_by_place[2].try(:count) || 0
      @third_place = horse_races_by_place[3].try(:count) || 0
      @unplaced = unplaced_horse_races(horse_races_by_place).try(:count) || 0
    end

    private

    def unplaced_horse_races(horse_races_by_place)
      horse_races_by_place.select do |order_of_arrival, _horse_races|
        order_of_arrival >= 4
      end.values.flatten
    end
  end
end
