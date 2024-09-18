class AddPrefectureIdToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :prefecture_id, :integer
  end
end
