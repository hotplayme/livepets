class AddCountryIdToUserAndCity < ActiveRecord::Migration
  def change
    add_column :users, :country_id, :integer
    add_column :cities, :country_id, :integer
  end
end
