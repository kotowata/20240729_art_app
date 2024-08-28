class AddStartDateAndEndDateToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :start_date, :date
    add_column :posts, :end_date, :date
  end
end
