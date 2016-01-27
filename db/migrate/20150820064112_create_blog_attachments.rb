class CreateBlogAttachments < ActiveRecord::Migration
  def change
    create_table :blog_attachments do |t|
      t.string :file
      t.boolean :main
      t.integer :blog_id
      t.timestamps null: false
    end
  end
end
