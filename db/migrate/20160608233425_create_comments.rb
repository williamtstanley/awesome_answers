class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :bod

      t.timestamps null: false
    end
  end
end
