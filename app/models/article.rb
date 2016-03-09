class Article < ActiveRecord::Base

  include Votable

  has_and_belongs_to_many :tags
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :article_attachments

  has_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
