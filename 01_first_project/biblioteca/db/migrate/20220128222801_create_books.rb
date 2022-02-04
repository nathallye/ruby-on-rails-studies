class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :description
      t.string :genre
      t.integer :quantity

      t.timestamps
    end
  end
end
