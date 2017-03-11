class AddMyFeedCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :my_feed_count, :integer, default: 0
  end
end
