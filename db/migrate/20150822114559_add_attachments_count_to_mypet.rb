class AddAttachmentsCountToMypet < ActiveRecord::Migration
  def change
    add_column :mypets, :pet_attachments_count, :integer, default: 0
  end
end
