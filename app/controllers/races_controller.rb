class RacesController < ApplicationController
  def index
    @races = Race.all
  end

  def show
    @race = Race.find(params[:id])
    @race_hoses = @race.raceHoses.sort do
      |a,b| a[:hose_num].to_i <=> b[:hose_num].to_i
    end 
  end
end
