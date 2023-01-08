class Construction < ApplicationRecord
  has_many :rods, dependent: :destroy

  accepts_nested_attributes_for :rods, allow_destroy: true

  validates :name, presence: true
end
