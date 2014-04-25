class Location < ActiveRecord::Base
  validates :title, presence: true
  validates :address, presence: true
end
