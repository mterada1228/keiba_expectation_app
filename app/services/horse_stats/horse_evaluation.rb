# 馬別統計データクラス
module HorseStats
  class HorseEvaluation
    attr_reader :results_by_course_condition

    def initialize(results_by_course_condition:)
      @results_by_course_condition = results_by_course_condition
    end
  end
end
