module HorseStats
  class ResultsByCourseCondition
    attr_reader :firm, :good, :yielding, :soft

    def initialize(horse_races:)
      create_stats(horse_races)
    end

    def create_stats(horse_races)
      by_course_condition = horse_races.group_by { |horse_race| horse_race.race.course_condition }
      @firm = HorsePodiums.new(by_course_condition['firm'])
      @good = HorsePodiums.new(by_course_condition['good'])
      @yielding = HorsePodiums.new(by_course_condition['yielding'])
      @soft = HorsePodiums.new(by_course_condition['soft'])
    end
  end
end
