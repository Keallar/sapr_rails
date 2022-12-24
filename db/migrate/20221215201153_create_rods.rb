class CreateRods < ActiveRecord::Migration[7.0]
  def change
    create_table :rods do |t|
      t.integer :place_id
      t.integer :l
      t.integer :a
      t.integer :e
      t.integer :b
      t.integer :f
      t.integer :q
      t.timestamps
    end
  end
end
