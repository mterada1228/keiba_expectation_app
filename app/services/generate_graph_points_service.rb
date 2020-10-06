#
# create graph plot of horse model
#
class GenerateGraphPointsService
  WON_RACES_COLOR = '#FFFF00' # yellow
  RACES_LOST_BY_0_POINT_2_SECONDS_COLOR = '#008000' # green
  RACES_LOST_BY_1_SECOND_COLOR = '#0000FF' # blue
  RACES_LOST_BY_MORE_THAN_1_SECOND = '#A9A9A9' # gray

  def initialize(horse)
    @horse = horse
  end

  def call
    horse_race_results.map do |horse_race_result|
      generate_graph_point(horse_race_result)
    end
  end

  private

  attr_reader :horse

  def horse_race_results
    horse.horse_race_results
  end

  def generate_graph_point(horse_race_result)
    graph_point(horse_race_result, graph_point_color(horse_race_result))
  end

  def graph_point(horse_race_result, color)
    race_result = horse_race_result.race_result

    { name: race_result.name,
      data: [[race_result.RPCI, race_result.ave_1F]],
      color: color }
  end

  def graph_point_color(horse_race_result)
    if horse_race_result.rank == '1'
      return WON_RACES_COLOR
    elsif horse_race_result.time_diff.to_f <= 0.2
      return RACES_LOST_BY_0_POINT_2_SECONDS_COLOR
    elsif horse_race_result.time_diff.to_f <= 1.0
      return RACES_LOST_BY_1_SECOND_COLOR
    else
      RACES_LOST_BY_MORE_THAN_1_SECOND
    end
  end
end
