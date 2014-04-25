class MapsController < ApplicationController
  def index
    @map = Map.new
    @locations = Location.all[1..10]
  end

  def create
    @map = Map.new(map_params)
    if @map.save
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      flash[:alert] = 'Bad Search'
      redirect_to :root
    end

  end


private
  def map_params
    params.require(:map).permit(:title, :location)
  end

end
