class PetAttachment < ActiveRecord::Base

  belongs_to :user
  belongs_to :mypet
  mount_uploader :file, PetUploader

end
