class AddDateToUsersAndMypets < ActiveRecord::Migration
  def change
    add_column :users,  :birthday, :date
    add_column :mypets, :birthday, :date
  end
end
