module HorseStats
  class ResultsByCourseCondition
    attr_reader(*Race.course_conditions.keys)

    def initialize(horse_races:)
      create_stats(horse_races)
    end

    def create_stats(horse_races)
      Race.course_conditions.each_key do |course_condition|
        instance_variable_set("@#{course_condition}",
                              HorsePodiums.new(
                                horse_races.select do |horse_race|
                                  horse_race.race.course_condition == course_condition
                                end
                              ))
      end
    end
  end
end
