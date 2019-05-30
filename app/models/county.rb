class County < ApplicationRecord
  belongs_to :state
  has_many :cities

  validates_presence_of :name
end
