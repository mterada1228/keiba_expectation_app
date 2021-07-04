module HorseStats
  class BestTimesByCourse
    attr_reader :times

    def initialize(horse_races:)
      @times = create_stats(horse_races)
    end

    private

    def create_stats(horse_races)
      group_by_course(horse_races).values.map do |horse_races_by_course|
        CourseTime.new(horse_races_by_course.min_by(&:time))
      end
    end

    def group_by_course(horse_races)
      grouped = horse_races.group_by do |horse_race|
        [horse_race.course_type, horse_race.distance]
      end
      grouped.sort_by { |k, _| [Race.course_types[k[0]], k[1]] }.to_h
    end
  end
end
