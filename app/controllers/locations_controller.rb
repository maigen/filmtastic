class LocationsController < ApplicationController

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if location.save
      redirect_to root_path, notice: "Location Saved!"
    else
      render new_location_path, alert: "Incorrect Entry, please try again."
    end
  end

  def seed
    if Location.all.length < 20
      begin
        File.open("locationsFiles.txt", "r") do |f|
          f.each_line do |line|
            stuff = line.split("***")
            Location.create({title: stuff[0], address: stuff[1]})
          end
        end
      rescue
        flash[:alert] = "create from file error"
      end
    end
      redirect_to root_path
  end

  private

  def location_params
    params.require(:location).permit(:title, :address)

  end
end
