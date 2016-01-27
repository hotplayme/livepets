class ConvertAttachmentToPolymorphic < ActiveRecord::Migration
  def change
    remove_index  :attachments, :blog_id
    rename_column :attachments, :blog_id, :attachable_id
    add_column    :attachments, :attachable_type, :string

    add_index     :attachments, [:attachable_id, :attachable_type]
  end
end
