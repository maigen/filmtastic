class CreateScrape < ActiveRecord::Migration
  def change
    create_table :scrapes do |t|
      t.string :url
      t.text :movie_hash
    end
  end
end
