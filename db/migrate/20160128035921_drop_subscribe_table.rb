class DropSubscribeTable < ActiveRecord::Migration
  def change
    drop_table :subscribes
  end
end
