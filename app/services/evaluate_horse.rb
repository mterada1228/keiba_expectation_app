# 馬別統計データインスタンスを作成するクラス
class EvaluateHorse
  def initialize(horse)
    @horse = horse
    @horse_evaluation = HorseEvaluation.new
  end

  def call
    @horse_evaluation.results_by_course_condition =
      HorseRaceStats.new(horse: @horse, column: :course_condition)
    @horse_evaluation
  end
end
