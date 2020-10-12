#
# Horses Controller
#
class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    binding.pry
    @horse = Horse.includes(:race_results).find(params[:id])
    @graph_points = GenerateRpciAve1fScatterPlotService.new(@horse).call
  end
end
