class Event < ActiveRecord::Base
  attr_accessible :title, :chronicle_id, :start_date, :end_date, :description, :latitude, :location, :longitude, :image_url
  validates_presence_of :title, :latitude, :longitude
  belongs_to :chronicle

  serialize :properties, Hash
  geocoded_by :location

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

  def print_dates
    date_string = self.end_date ? " - " + self.end_date.strftime("%b %e %Y") : ""
    self.start_date.strftime("%b %e %Y") + date_string
  end

end
