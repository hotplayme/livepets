class Article < ActiveRecord::Base

  include Votable

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  has_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
