# 馬別統計データインスタンスを作成するクラス
module HorseStats
  class EvaluateHorse
    def initialize(horse_races)
      @horse_races = horse_races
    end

    def call
      HorseEvaluation.new(
        podiums_by_course_condition:
          HorseStats::PodiumsByCourseCondition.new(horse_races: @horse_races)
      )
    end
  end
end
