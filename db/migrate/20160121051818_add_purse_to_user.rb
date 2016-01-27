class AddPurseToUser < ActiveRecord::Migration
  def change
    add_column :users, :purse, :string
  end
end
