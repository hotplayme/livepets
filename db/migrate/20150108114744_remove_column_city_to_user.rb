class RemoveColumnCityToUser < ActiveRecord::Migration
  def change
    remove_column :users, :city
  end
end
