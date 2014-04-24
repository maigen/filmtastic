class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :location
      t.string :title

      t.timestamps
    end
  end
end
