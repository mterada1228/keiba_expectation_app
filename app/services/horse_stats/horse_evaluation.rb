# 馬別統計データクラス
module HorseStats
  class HorseEvaluation
    attr_reader :podiums_by_course_condition

    def initialize(podiums_by_course_condition:)
      @podiums_by_course_condition = podiums_by_course_condition
    end
  end
end
