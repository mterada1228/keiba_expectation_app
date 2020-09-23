class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def show
    @horse = Horse.find(params[:id])
    @data_to_be_plotted = @horse.plot_data
  end
end
