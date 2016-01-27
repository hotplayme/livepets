class RemoveSexDateFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :sex
    remove_column :users, :day
    remove_column :users, :month
    remove_column :users, :year
  end
end
