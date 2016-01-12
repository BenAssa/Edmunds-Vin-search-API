class CarsController < ApplicationController

  def index
    #while not needed by task requirements, an HTML  index helps testing 
    @cars = Car.examples
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def show
    @car = Car.find(params[:id])
    render json: @car
  end
end
