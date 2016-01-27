class BlogAttachment < ActiveRecord::Base

  belongs_to :blog, counter_cache: true
  mount_uploader :file, BlogUploader

end
