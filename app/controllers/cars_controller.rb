class CarsController < ApplicationController
  # GET /skills
  # GET /skills.json
  def index
    @cars = Car.examples
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @skills }
    end
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
    @car = Car.find(params[:id])
    render json: @car
  end
end
