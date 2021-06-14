module HorseStats
  class PodiumsByCourseCondition
    attr_reader :firm, :good, :yielding, :soft

    def initialize(horse_races:)
      create_stats(horse_races)
    end

    private

    def create_stats(horse_races)
      by_course_condition = horse_races.group_by { |horse_race| horse_race.race.course_condition }
      @firm = HorsePodiums.new(by_course_condition.fetch('firm', []))
      @good = HorsePodiums.new(by_course_condition.fetch('good', []))
      @yielding = HorsePodiums.new(by_course_condition.fetch('yielding', []))
      @soft = HorsePodiums.new(by_course_condition.fetch('soft', []))
    end
  end
end
