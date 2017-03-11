class CreateReviewAttachments < ActiveRecord::Migration
  def change
    create_table :review_attachments do |t|
      t.integer :review_id
      t.string  :file
      t.boolean :main, default: false
      t.timestamps null: false
    end
  end
end
