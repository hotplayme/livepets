class AddAttachmentsCountToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :blog_attachments_count, :integer, default: 0
  end
end
