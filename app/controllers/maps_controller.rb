class MapsController < ApplicationController
  def show
    @map = Map.find(params[:id])
    @locations = Location.all[31..40]
    @nearby_locations = Location.near(@map.location)
    @nearby_hash = Gmaps4rails.build_markers(@nearby_locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow location.title
    end
  end

  def index
    @map = Map.new
    @locations = Location.all[31..40]

    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow location.title
    end
  end

  def create
    @nearby_locations = Location.near(map_params[:location])
    @nearby_hash = Gmaps4rails.build_markers(@nearby_locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow location.title
    end

    @map = Map.new(map_params)
    if @map.save
      redirect_to map_path(@map)
    else
      flash[:alert] = 'Bad Search'
      redirect_to :back
    end

  end

  def update
    @map = Map.find(params[:id])
    if @map.update(map_params)
      redirect_to map_path(@map)
    else
      flash[:alert] = 'Bad Search'
      redirect_to :back
    end
  end


private
  def map_params
    params.require(:map).permit(:title, :location)
  end

end
