class AddAttachId < ActiveRecord::Migration
  def change
    add_column :attachments, :blog_id, :integer
    add_index :attachments, :blog_id
  end
end
