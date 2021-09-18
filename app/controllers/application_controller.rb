class ApplicationController < ActionController::Base
  add_flash_types :success, :danger

  rescue_from ActiveRecord::RecordNotFound do |_e|
    render template: 'errors/error_404', status: 404
  end

  rescue_from RailsParam::Param::InvalidParameterError do |_e|
    render template: 'errors/error_400', status: 400
  end
end
