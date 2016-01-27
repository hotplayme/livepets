class FixUsersFields < ActiveRecord::Migration
  def change
    remove_column :users, :anketa

    remove_column :users, :birthday

    remove_column :users, :country_id

    remove_column :users, :country

    add_column    :users, :approve, :boolean, default: false
    
  end
end
