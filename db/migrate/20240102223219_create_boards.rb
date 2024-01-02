class CreateBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :boards do |t|
      t.text :email
      t.integer :width
      t.integer :height
      t.integer :mine_count
      t.text :name
      t.datetime :created

      t.timestamps
    end
  end
end
