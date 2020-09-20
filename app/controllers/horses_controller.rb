class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    @horse = Horse.find(params[:id])
    @ploted_data = createPlotedData(@horse.horse_race_results)
  end

  private

  def createPlotedData(horse_race_results)
    ploted_data = []
    racesWin(horse_race_results).each do |horse_race_result|
      race_result = horse_race_result.race_result
      ploted_data.push({name: race_result.name, 
                        data: [[race_result.RPCI, race_result.ave_1F]],
                        color: "#ffff00"
      })
    end
    ploted_data
  end

  def racesWin(horse_race_results)
    horse_race_results.select { |horse_race_result| horse_race_result.rank == '1' }
  end
end
