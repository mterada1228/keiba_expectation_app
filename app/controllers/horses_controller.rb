#
# Horses Controller
#
class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    @horse = Horse.find(params[:id])
    generate_graph_point_service = GenerateGraphPointsService.new(@horse)
    @graph_points = generate_graph_point_service.generate_graph_points
  end
end
