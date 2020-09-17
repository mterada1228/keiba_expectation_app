class HosesController < ApplicationController
  def index
    @hoses = Hose.all
  end

  def show
    @hose = Hose.find(params[:id])
    @ploted_data = createPlotedData(@hose.hoseRaceResults)
  end

  private

  def createPlotedData(hoseRaceResults)
    ploted_data = []
    racesWin(hoseRaceResults).each do |hoseRaceResult|
      race_result = hoseRaceResult.race_result
      ploted_data.push({name: race_result.name, 
                        data: [[race_result.RPCI, race_result.ave_1F]],
                        color: "#b00"
      })
    end
    ploted_data
  end

  def racesWin(hoseRaceResults)
    #TODO 優勝データのみ抽出する
  end
end
