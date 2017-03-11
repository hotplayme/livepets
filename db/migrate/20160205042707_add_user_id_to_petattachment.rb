class AddUserIdToPetattachment < ActiveRecord::Migration
  def change
    add_column :pet_attachments, :user_id, :integer, index: true
  end
end
