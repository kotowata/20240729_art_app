class AddUserIconToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :user_icon, :string
  end
end
