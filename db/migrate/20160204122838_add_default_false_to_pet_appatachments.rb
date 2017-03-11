class AddDefaultFalseToPetAppatachments < ActiveRecord::Migration
  def change
    change_column :pet_attachments, :main, :boolean, default: false
  end
end
