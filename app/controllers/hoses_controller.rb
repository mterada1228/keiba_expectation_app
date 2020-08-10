class HosesController < ApplicationController
  def show
    @hose = Hose.find(params[:id])
  end
end
