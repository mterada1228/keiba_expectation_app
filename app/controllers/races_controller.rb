class RacesController < ApplicationController
  def index
    @races = Race.all
  end

  def show
    @race = Race.find(params[:id])
    @race_horses = @race.race_horses.sort do
      |a,b| a.horse_number <=> b.horse_number
    end 
  end
end
