# 馬別統計データインスタンスを作成するクラス
module HorseStats
  class EvaluateHorse
    def initialize(horse_races)
      @horse_races = horse_races
      @horse_evaluation = HorseEvaluation.new
    end

    def call
      @horse_evaluation.results_by_course_condition =
        HorseStats::ResultsByCourseCondition.new(horse_races: @horse_races)
      @horse_evaluation
    end
  end
end
