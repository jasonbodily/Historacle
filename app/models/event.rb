class Event < ActiveRecord::Base
  attr_accessible :date, :description, :latitude, :location, :longitude, :title, :properties
  validates_presence_of :title
  belongs_to :chronicle

  serialize :properties, Hash
  geocoded_by :location
  after_validation :geocode

  validate :validate_properties

  def validate_properties
    chronicle.fields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, "must not be blank!  "
      end
    end
  end

end
