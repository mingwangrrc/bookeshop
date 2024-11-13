class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.date :publication_date

      t.timestamps
    end
  end
end
