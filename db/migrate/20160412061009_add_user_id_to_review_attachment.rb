class AddUserIdToReviewAttachment < ActiveRecord::Migration
  def change
    add_column :review_attachments, :user_id, :integer
  end
end
