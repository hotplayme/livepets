class AddAddToNotice < ActiveRecord::Migration
  def change
    add_column :notices, :add, :boolean, default: true
  end
end
