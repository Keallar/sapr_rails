# frozen_string_literal: true

class Construction < ApplicationRecord
  has_many :rods, dependent: :destroy

  validates_presence_of :name

  accepts_nested_attributes_for :rods
end
