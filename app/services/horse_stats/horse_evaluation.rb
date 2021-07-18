# 馬別統計データクラス
module HorseStats
  class HorseEvaluation
    attr_reader :podiums_by_course_condition, :best_times_by_course

    def initialize(podiums_by_course_condition:, best_times_by_course:)
      @podiums_by_course_condition = podiums_by_course_condition
      @best_times_by_course = best_times_by_course
    end
  end
end
