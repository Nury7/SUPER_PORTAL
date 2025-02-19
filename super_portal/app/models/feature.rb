class Feature < ApplicationRecord
  has_and_belongs_to_many :properties
  validates :name, presence: true, uniqueness: true
end
