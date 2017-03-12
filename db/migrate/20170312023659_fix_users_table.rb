class FixUsersTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :writer
    remove_column :users, :balance
    remove_column :users, :purse
  end
end
