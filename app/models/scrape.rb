class Scrape < ActiveRecord::Base
  require 'open-uri'
  validates :name, presence: true

  def web_scrape(url)
    begin
      doc = Nokogiri::HTML(open(url))
      text  = doc.at('body').inner_text
      locationsText = text.scan(/.*is filming at.*/)
      movie_locations = {}


      locationsText.each do |lt|
        movie = lt.split(" is filming at ")[0]
        location = lt.split(" is filming at ")[1].scan(/^[^\(]*/)
        movie_locations[movie] = location.join.rstrip
      end
      movie_locations
    rescue
      return false
    end
  end
end
