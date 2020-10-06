#
# Horses Controller
#
class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    @horse = Horse.preload([:horse_race_results, { horse_race_results: :race_result }]).find(params[:id])
    @graph_points = GenerateGraphPointsService.new(@horse).call
  end
end
