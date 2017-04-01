class PetAttachment < ActiveRecord::Base

  belongs_to :user
  belongs_to :pet
  mount_uploader :file, PetUploader

end
