class BlogAttachment < ActiveRecord::Base

  belongs_to :blog
  mount_uploader :file, BlogUploader


end
