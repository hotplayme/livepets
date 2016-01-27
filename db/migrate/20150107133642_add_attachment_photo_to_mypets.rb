class AddAttachmentPhotoToMypets < ActiveRecord::Migration
  def self.up
    change_table :mypets do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :mypets, :photo
  end
end
