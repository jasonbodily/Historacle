class Library < ActiveRecord::Base
  attr_accessible :name, :user_id, :chronicles_attributes
  has_many :chronicles, :dependent => :destroy
  belongs_to :user
end
