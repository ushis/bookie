class HealthChecksController < ApplicationController

  # GET /health
  def show
    result = run Health::Show
    render json: result['system'].to_h
  end
end
