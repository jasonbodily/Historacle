class ChronicleField < ActiveRecord::Base
  belongs_to :chronicle
  attr_accessible :field_type, :name, :required
end
