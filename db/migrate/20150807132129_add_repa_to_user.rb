class AddRepaToUser < ActiveRecord::Migration
  def change
    add_column :users, :repa, :float, default: 0.00
    add_column :users, :repa_total, :float, default: 0.00
  end
end
