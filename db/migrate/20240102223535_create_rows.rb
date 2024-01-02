class CreateRows < ActiveRecord::Migration[7.1]
  def change
    create_table :rows do |t|
      t.references :board, null: false, foreign_key: true
      t.integer :row_index
      t.integer :col_index
      t.text :row_content

      t.timestamps
    end
  end
end
