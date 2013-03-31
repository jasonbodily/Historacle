class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date, :latitude, :longitude, :image_url, :location, :description

end
