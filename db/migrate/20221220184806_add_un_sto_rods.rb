class AddUnStoRods < ActiveRecord::Migration[7.0]
  def change
    add_column :rods, :u, :float, array: true, default: []
    add_column :rods, :n, :float, array: true, default: []
    add_column :rods, :s, :float, array: true, default: []
    add_column :rods, :delta_0, :float
    add_column :rods, :delta_l, :float

    change_column :rods, :l, :float
    change_column :rods, :a, :float
    change_column :rods, :e, :float
    change_column :rods, :b, :float
    change_column :rods, :f, :float
    change_column :rods, :q, :float
  end
end
