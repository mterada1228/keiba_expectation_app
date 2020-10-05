#
# Races controller
#
class RacesController < ApplicationController
  def index
    @races = Race.all
  end

  def show
    @race = Race.find(params[:id])
    @race_horses = @race.race_horses_sorted_by_horse_number
  end
end
