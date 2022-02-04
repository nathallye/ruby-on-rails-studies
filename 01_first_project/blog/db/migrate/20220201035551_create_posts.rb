class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :content
      t.string :string
      t.datetime :published_at
      t.string :author

      t.timestamps
    end
  end
end
