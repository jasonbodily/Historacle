class Library < ActiveRecord::Base
  attr_accessible :name, :chronicles_attributes
  has_many :chronicles, :dependent => :destroy
end
