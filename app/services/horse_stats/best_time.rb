module HorseStats
  class BestTime
    attr_reader :distance, :course_type, :time

    def initialize(horse_race)
      @distance = horse_race.distance
      @course_type = horse_race.course_type
      @time = horse_race.time.strftime('%-M:%S.%1L')
    end
  end
end
