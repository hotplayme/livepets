class AddIndexUserId < ActiveRecord::Migration
  def change
    add_index :topics, :user_id
  end
end
