module HorseStats
  class CourseTime
    def initialize(horse_race)
      @horse_race = horse_race
    end

    def distance
      @horse_race.distance
    end

    def course_type
      @horse_race.course_type
    end

    def time
      @horse_race.time
    end

    def ==(other)
      distance == other.distance && course_type == other.course_type && time == other.time
    end
  end
end
