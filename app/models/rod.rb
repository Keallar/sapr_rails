class Rod < ApplicationRecord
  has_many :joints
  belongs_to :construction

  accepts_nested_attributes_for :joints

  validates :place_id, numericality: { only_integer: true }
  validates :l, :a, :e, :b, :f, :q, presence: true
end
