class CreatePages < ActiveRecord::Migration[7.2]
  def change
    create_table :pages do |t|
      t.text :about
      t.text :contact
      t.text :story
      t.text :purpose

      t.timestamps
    end
  end
end
