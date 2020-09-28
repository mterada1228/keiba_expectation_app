class HosesController < ApplicationController
  def index
    @hoses = Hose.all
  end

  def show
    @hose = Hose.find(params[:id])
  end
end
