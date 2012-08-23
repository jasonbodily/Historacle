class Event < ActiveRecord::Base
  attr_accessible :date, :description, :latitude, :location, :longitude, :title, :value1, :value2, :value3
  belongs_to :chronicle
end
