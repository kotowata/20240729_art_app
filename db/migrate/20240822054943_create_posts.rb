class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content
      t.string :post_image
      t.string :event_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
