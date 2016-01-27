class AddAttachmentAvatarToBreeds < ActiveRecord::Migration
  def self.up
    change_table :breeds do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :breeds, :avatar
  end
end
