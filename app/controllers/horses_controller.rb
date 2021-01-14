#
# Horses Controller
#
class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    @horse = Horse.find(params[:id])
    @horse_race_results = @horse
                          .horse_race_results
                          .includes(:race)
                          .order('races.start DESC')
    @graph_points = GenerateRpciAve1fScatterPlotsService.new(@horse).call
  end
end
