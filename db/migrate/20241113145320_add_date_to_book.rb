class AddDateToBook < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :date, :date
  end
end
