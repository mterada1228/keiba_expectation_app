#
# Horses Controller
#
class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    @horse = Horse.includes(:race_results).find(params[:id])
    @graph_points = GenerateRpciAve1fScatterPlotsService.new(@horse).call
  end
end
