class Horse < ApplicationRecord
  has_many :horse_race_results
  has_many :race_horses

  def plot_data
    data = []
    data.concat(races_win)
  end

  private

  def races_win
    horse_race_results.map do |horse_race_result|
      race_result = horse_race_result.race_result
      { name: race_result.name, 
        data: [[race_result.RPCI, race_result.ave_1F]],
        color: "#ffff00" }
    end
  end
end