class PetAttachment < ActiveRecord::Base

  belongs_to :mypet, counter_cache: true
  mount_uploader :file, PetUploader

end
