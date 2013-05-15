class Area < ActiveRecord::Base
  attr_accessible :name, :coordinates, :start_date, :end_date
  validates_presence_of :name

  #belongs_to :chronicle

end
