class ChangeDatatypeContentOfPosts < ActiveRecord::Migration[7.2]
  def change
    change_column :posts, :content, :string
  end
end
