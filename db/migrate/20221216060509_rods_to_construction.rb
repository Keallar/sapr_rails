class RodsToConstruction < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :rods, :construction, index: true, foreign_key: true
  end
end
