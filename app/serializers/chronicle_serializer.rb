class ChronicleSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :events
  self.root = false
end
