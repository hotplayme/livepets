class Attachment < ActiveRecord::Base

  belongs_to :attachable, polymorphic: true

  mount_uploader :file, FileUploader
  mount_uploader :file, AvatarUploader

  def initialize(*args)
    super(*args)
    self.class.mount_uploader(:file, FileUploader) if self.attachable.class.name == 'Blog'
    #self.class.mount_uploader(:file, AvatarUploader) if self.attachable.class.name == 'User'
  end

end
