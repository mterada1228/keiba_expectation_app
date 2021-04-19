#
# Horses Controller
#
class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    @horse = Horse.find(params[:id])
    @horse_races = @horse.horse_races.includes(:race).order('races.start DESC')
    @graph_points = GenerateRpciAve1fScatterPlotsService.new(@horse).call
    @horse_evaluation = EvaluateHorse.new(@horse).call
  end
end
