class CreateArticleAttachments < ActiveRecord::Migration
  def change
    create_table :article_attachments do |t|
      t.string :file
      t.integer :article_id
      t.timestamps null: false
    end
  end
end
