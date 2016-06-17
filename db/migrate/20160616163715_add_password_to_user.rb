class AddPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
  end

  add_index :users, :email, unique: true
end
