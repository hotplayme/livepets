class ReviewAttachment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  mount_uploader :file, ReviewUploader
end
