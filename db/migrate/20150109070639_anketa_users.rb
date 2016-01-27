class AnketaUsers < ActiveRecord::Migration
  def change
    add_column :users, :anketa, :boolean, default: false
  end
end
