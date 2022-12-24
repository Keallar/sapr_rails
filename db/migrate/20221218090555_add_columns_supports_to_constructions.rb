class AddColumnsSupportsToConstructions < ActiveRecord::Migration[7.0]
  def change
    add_column :constructions, :left_support, :boolean, default: false
    add_column :constructions, :right_support, :boolean, default: false
  end
end
