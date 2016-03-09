class ArticleAttachment < ActiveRecord::Base

  belongs_to :article
  mount_uploader :file, ArticleUploader

end
