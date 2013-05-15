class AreaSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :end_date, :coordinates
end
