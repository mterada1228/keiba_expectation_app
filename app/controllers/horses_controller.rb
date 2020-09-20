class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    @horse = Horse.find(params[:id])
    @ploted_data = createPlotedData(@horse.horse_race_results)
  end

  private

  def createPlotedData(hose_race_results)
    ploted_data = []
    racesWin(hose_race_results).each do |hose_race_result|
      race_result = hose_race_result.race_result
      ploted_data.push({name: race_result.name, 
                        data: [[race_result.RPCI, race_result.ave_1F]],
                        color: "#b00"
      })
    end
    ploted_data
  end

  def racesWin(hose_race_results)
    #TODO 優勝データのみ抽出する
  end
end
