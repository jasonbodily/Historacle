class Event < ActiveRecord::Base
  attr_accessible :date, :description, :latitude, :location, :longitude, :title, :value1, :value2, :value3
  validates_presence_of :title
  belongs_to :chronicle


  geocoded_by :location
  after_validation :geocode

end
