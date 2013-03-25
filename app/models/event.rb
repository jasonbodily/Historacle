class Event < ActiveRecord::Base
  attr_accessible :title, :start_date, :end_date, :description, :latitude, :location, :longitude, :image_url
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

  def self.import(file, chronicle)
    CSV.foreach(file.path, headers: true) do |row|
      event = find_by_id(row["id"]) || chronicle.events.build
      event.attributes = row.to_hash.slice(*accessible_attributes)
      event.save!
    end
  end

end
