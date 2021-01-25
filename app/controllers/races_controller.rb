#
# Races controller
#
class RacesController < ApplicationController
  def index
    @races = Race.all
  end

  def show
    @race = Race.find(params[:id])
    @horse_races = @race.horse_races.order('horse_number')
  end
end
