class Chronicle < ActiveRecord::Base
  attr_accessible :description, :name, :subject, :use_value1, :use_value2, :use_value3, :value1_title, :value2_title, :value3_title
end
