class Construction < ApplicationRecord
  has_many :rods, dependent: :destroy

  accepts_nested_attributes_for :rods
end
