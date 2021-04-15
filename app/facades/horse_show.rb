class HorseShow
  def initialize(horse)
    @horse = horse
  end

  def results_by_course_condition
    RaceResult.course_conditions.keys.map do |condition|
      races = @horse.races.races_by_condition(condition)
      [
        condition.to_sym, {
          first: races.first_place_races.count,
          second: races.second_place_races.count,
          third: races.third_place_races.count,
          unplaced: races.unplaced_races.count
        }
      ]
    end.to_h
  end
end
