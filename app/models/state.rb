class State < ApplicationRecord
  has_many :cities
  has_many :counties

  validates_presence_of :name
  validates :name, uniqueness: true

end
