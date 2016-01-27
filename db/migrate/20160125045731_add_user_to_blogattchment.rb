class AddUserToBlogattchment < ActiveRecord::Migration
  def change
    add_column :blog_attachments, :user_id, :integer
  end
end
