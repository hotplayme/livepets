class AddApproveToTopicAndPost < ActiveRecord::Migration
  def change
    add_column :topics, :approve, :boolean, default: false
    add_column :posts,  :approve, :boolean, default: false
  end
end
