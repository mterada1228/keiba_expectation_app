# 馬別統計データインスタンスを作成するクラス
class EvaluateHorse
  def initialize(horse)
    @horse = horse
    @horse_evaluation = HorseEvaluation.new
  end

  def call
    @races_by_place = races_by_place
    @horse_evaluation.results_by_course_condition = results_by_course_condition
    @horse_evaluation
  end

  private

  def races_by_place
    # TODO 以下データはキャッシュサーバに保存する
    OpenStruct.new({ first_place_races: @horse.races.first_place_horse_races,
                     second_place_races: @horse.races.second_place_horse_races,
                     third_place_races: @horse.races.third_place_horse_races,
                     unplaced_races: @horse.races.unplaced_horse_races })
  end

  def results_by_course_condition
    OpenStruct.new({ firm: create_results_by_value_hash(:course_condition, 'firm'),
                     good: create_results_by_value_hash(:course_condition, 'good'),
                     yielding: create_results_by_value_hash(:course_condition, 'yielding'),
                     soft: create_results_by_value_hash(:course_condition, 'soft') })
  end

  def create_results_by_value_hash(column, value)
    OpenStruct.new(
      { first_place: @races_by_place.first_place_races.select do |race|
                       race.send(column) == value
                     end.count,
        second_place: @races_by_place.second_place_races.select do |race|
                        race.send(column) == value
                      end.count,
        third_place: @races_by_place.third_place_races.select do |race|
                       race.send(column) == value
                     end.count,
        unplaced: @races_by_place.unplaced_races.select do |race|
                    race.send(column) == value
                  end.count }
    )
  end
end
