require 'spec_helper'
describe Scrape do
  context '#web_scrape' do
    it 'scrapes page for movie locations' do
      @scrape = Scrape.new
      test_locations = @scrape.web_scrape('http://www.onlocationvacations.com/2014/01/')
      test_locations['Castle'].to_s.should eq '506 S Grand Ave, Los Angeles'
    end
  end

  context '#links_one_deep' do
    it 'scrapes page for all child links' do
      @scrape = Scrape.new
      test_links = @scrape.links_one_deep('http://www.onlocationvacations.com/archives/')
      test_links.length.should >= 91
    end
  end
end
