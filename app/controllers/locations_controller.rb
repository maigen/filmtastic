class LocationsController < ApplicationController
  def new
  end

  def create
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
end
