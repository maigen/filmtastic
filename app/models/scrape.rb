class Scrape < ActiveRecord::Base
  require 'open-uri'

  def web_scrape(url)
      begin
        doc = Nokogiri::HTML(open(url))

        text  = doc.at('body').inner_text
        locationsText = text.scan(/.*is filming at.*/)
        movie_locations = {}

        locationsText.each do |lt|
          begin
          movie = lt.split(" is filming at ")[0]
          movie.tr!('•', '')
          location = lt.split(" is filming at ")[1].scan(/^[^\(]*/)
          movie_locations[movie] = location.join.rstrip
          rescue
            puts "some error"
          end
        end
        movie_locations
      rescue
        puts "error"
      end
    end

    def links_one_deep(url)
      doc = Nokogiri::HTML(open(url))
      links = []
      raw_links = doc.search("a").to_a

      raw_links.each do |raw_link|
        lnk = raw_link.to_s.match(/http.*\/"/).to_s
        link = lnk[0..lnk.length-2]
        if link.length == 43
          links << link
        end
      end
      links
    end

    def scrape_one_deep(url)
      movies = {}
      links = links_one_deep(url)
      links.each do |link|
        if link != nil
          begin
            linked_movies = web_scrape(link)
            begin
              movies.merge!(linked_movies)
            rescue
              puts "couldnt merge"
            end
          rescue
            puts "couldnt scrape #{link}"
          end
        end
      end
      movies
    end
end
