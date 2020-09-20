#
class Horse < ApplicationRecord
  has_many :horse_race_results
  has_many :race_horses

  def plot_data
    data = []
    data.concat(races_win)
    data.concat(races_lost_by_0_point_2_secounds)
    data.concat(races_lost_by_1_secounds)
    data.concat(races_lost_by_greater_than_1_secounds)
  end

  private

  def data_array(races, color)
    races.map do |race|
      result = race.race_result
      { name: result.name,
        data: [[result.RPCI, result.ave_1F]],
        color: color }
    end
  end

  def races_win
    races = horse_race_results.select do |horse_race_result|
      horse_race_result.rank == '1'
    end

    data_array(races, '#FFFF00')
  end

  def races_lost_by_0_point_2_secounds
    races = horse_race_results.select do |horse_race_result|
      horse_race_result.rank != '1' && horse_race_result.time_diff.to_f <= 0.2
    end

    data_array(races, '#008000')
  end

  def races_lost_by_1_secounds
    races = horse_race_results.select do |horse_race_result|
      horse_race_result.rank != '1' &&
      horse_race_result.time_diff.to_f > 0.2 &&
      horse_race_result.time_diff.to_f <= 1.0
    end

    data_array(races, '#0000FF')
  end

  def races_lost_by_greater_than_1_secounds
    races = horse_race_results.select do |horse_race_result|
      horse_race_result.rank != '1' && horse_race_result.time_diff.to_f > 1.0
    end

    data_array(races, '#A9A9A9')
  end
end
