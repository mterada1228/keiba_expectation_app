#
# Races controller
#
class RacesController < ApplicationController
  def index
    @races = Race.all
  end

  def show
    @race = Race.find_by_id(params[:id])
    @race_horses = @race.race_horses.sort do |a, b|
      a[:horse_number].to_i <=> b[:horse_number].to_i
    end
  end
end
