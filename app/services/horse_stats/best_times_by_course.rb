module HorseStats
  class BestTimesByCourse
    attr_reader :best_times

    def initialize(horse_races:)
      @best_times = create_stats(horse_races)
    end

    def create_stats(horse_races)
      race1 = Race.new(distance: 1000, course_type: :turf)
      horse_race1 = HorseRace.new(time: '00:01:10.4', race: race1)
      race2 = Race.new(distance: 2000, course_type: :turf)
      horse_race2 = HorseRace.new(time: '00:02:10.5', race: race2)
      race3 = Race.new(distance: 1600, course_type: :dirt)
      horse_race3 = HorseRace.new(time: '00:01:50.6', race: race3)
      race4 = Race.new(distance: 1800, course_type: :dirt)
      horse_race4 = HorseRace.new(time: '00:02:00.7', race: race4)
      [
        BestTime.new(horse_race1),
        BestTime.new(horse_race2),
        BestTime.new(horse_race3),
        BestTime.new(horse_race4)
      ]
    end
  end
end
