#
# Horses Controller
#
class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    @horse = Horse.includes(horse_races: [:race]).find(params[:id])
    @horse_races = @horse.horse_races.sort { |a, b| b.race.start <=> a.race.start }
    @graph_points = GenerateRpciAve1fScatterPlotsService.new(@horse).call
    @horse_evaluation = HorseStats::EvaluateHorse.new(@horse_races).call
  end
end
