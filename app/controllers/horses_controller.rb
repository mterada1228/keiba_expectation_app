#
# Horses Controller
#
class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    @horse = Horse.includes(:race_results).find(params[:id])
    @horse_race_results = @horse
                          .horse_race_results
                          .includes(:race_result)
                          .order('race_results.date DESC')
    @graph_points = GenerateRpciAve1fScatterPlotsService.new(@horse).call
  end
end
