class Location < ActiveRecord::Base
  validates :title, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  after_create :remove_bad_address

  def remove_bad_address
    if self.latitude == nil || self.longitude == nil
      self.delete
    end
  end


end
