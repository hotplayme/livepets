class RemoveCityId16Default3 < ActiveRecord::Migration
  def change
    remove_column :users, :city_id
    add_column    :users, :city_id, :integer
  end
end
