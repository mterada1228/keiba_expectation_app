# 馬別統計データインスタンスを作成するクラス
module HorseStats
  class EvaluateHorse
    def initialize(horse_races)
      @horse_races = horse_races
    end

    def call
      HorseEvaluation.new(
        results_by_course_condition:
          HorseStats::ResultsByCourseCondition.new(horse_races: @horse_races)
      )
    end
  end
end
