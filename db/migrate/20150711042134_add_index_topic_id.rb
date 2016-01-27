class AddIndexTopicId < ActiveRecord::Migration
  def change
    add_index :posts,:topic_id
    add_index :posts, :user_id
  end
end
