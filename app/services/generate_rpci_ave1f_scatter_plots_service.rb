#
# create graph plot of horse model
#
class GenerateRpciAve1fScatterPlotsService
  WON_RACE_COLOR = '#FFFF00'.freeze # yellow
  RACE_LOST_BY_0_POINT_2_SECONDS_COLOR = '#008000'.freeze # green
  RACE_LOST_BY_1_SECOND_COLOR = '#0000FF'.freeze # blue
  RACE_LOST_BY_MORE_THAN_1_SECOND_COLOR = '#A9A9A9'.freeze # gray

  def initialize(horse)
    @horse = horse
  end

  def call
    horse.horse_races.map do |horse_race|
      generate_scatter_plot(horse_race)
    end
  end

  private

  attr_reader :horse

  def generate_scatter_plot(horse_race)
    scatter_plot(horse_race, scatter_plot_color(horse_race))
  end

  def scatter_plot(horse_race, color)
    { name: horse_race.race.name,
      data: [[horse_race.race.race_result.RPCI, horse_race.race.race_result.ave_1F]],
      color: color }
  end

  def scatter_plot_color(horse_race)
    if horse_race.order_of_arrival == 1
      WON_RACE_COLOR
    elsif horse_race.time_diff.to_f <= 0.2
      RACE_LOST_BY_0_POINT_2_SECONDS_COLOR
    elsif horse_race.time_diff.to_f <= 1.0
      RACE_LOST_BY_1_SECOND_COLOR
    else
      RACE_LOST_BY_MORE_THAN_1_SECOND_COLOR
    end
  end
end
