#
# Horses Controller
#
class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    @horse = Horse.includes(horse_races: [:race]).find(params[:id])
    @horse_races = @horse.horse_races.sort_by { |horse_race| horse_race.race.start }.reverse!
    @graph_points = GenerateRpciAve1fScatterPlotsService.new(@horse).call
    @horse_evaluation = HorseStats::EvaluateHorse.new(@horse_races).call
  end
end
