class DefaultIdCityUser < ActiveRecord::Migration
  def change
    change_column :users, :city_id, :integer, default: 16
  end
end
