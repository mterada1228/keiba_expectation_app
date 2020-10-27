#
# create graph plot of horse model
#
class GenerateRpciAve1fScatterPlotService
  WON_RACE_COLOR = '#FFFF00' # yellow
  RACE_LOST_BY_0_POINT_2_SECONDS_COLOR = '#008000' # green
  RACE_LOST_BY_1_SECOND_COLOR = '#0000FF' # blue
  RACE_LOST_BY_MORE_THAN_1_SECOND_COLOR = '#A9A9A9' # gray

  def initialize(horse)
    @horse = horse
  end

  def call
    horse_race_results.map do |horse_race_result|
      generate_scatter_plot(horse_race_result)
    end
  end

  private

  attr_reader :horse

  def horse_race_results
    horse.horse_race_results
  end

  def generate_scatter_plot(horse_race_result)
    scatter_plot(horse_race_result, scatter_plot_color(horse_race_result))
  end

  def scatter_plot(horse_race_result, color)
    race_result = horse_race_result.race_result

    { :name => race_result.name,
      :data => [[race_result.RPCI, race_result.ave_1F]],
      :color => color }
  end

  def scatter_plot_color(horse_race_result)
    if horse_race_result.rank == '1'
      WON_RACE_COLOR
    elsif horse_race_result.time_diff.to_f <= 0.2
      RACE_LOST_BY_0_POINT_2_SECONDS_COLOR
    elsif horse_race_result.time_diff.to_f <= 1.0
      RACE_LOST_BY_1_SECOND_COLOR
    else
      RACE_LOST_BY_MORE_THAN_1_SECOND_COLOR
    end
  end
end
