class Chronicle < ActiveRecord::Base
  attr_accessible :description, :name, :subject, :fields_attributes
  has_many :events, :dependent => :destroy
  has_many :fields, class_name: "ChronicleField"
  accepts_nested_attributes_for :fields, allow_destroy: true
  belongs_to :library

  def self.search(search)
    search ? where('name LIKE ?', "%#{search}%") : scoped
  end
end
