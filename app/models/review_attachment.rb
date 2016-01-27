class ReviewAttachment < ActiveRecord::Base
  belongs_to :review
  mount_uploader :file, ReviewUploader
end
