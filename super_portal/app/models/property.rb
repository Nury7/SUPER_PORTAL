class Property < ApplicationRecord
  belongs_to :location
  has_and_belongs_to_many :features

  validates :title, :description, :location, :external_id, presence: true
  validates :external_id, uniqueness: true
end
