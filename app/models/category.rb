class Category < ActiveRecord::Base
  has_many :videos

  validates_presence_of :name
  validates_uniqueness_of :name
end
