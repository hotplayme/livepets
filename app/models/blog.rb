class Blog < ActiveRecord::Base

  validates :title, presence:true, length: { minimum: 4, maximum: 65 }

  include Votable

  belongs_to :user
  has_many :comments,    as: :commentable,  dependent: :destroy
  has_many :subscribers, as: :subscribable, dependent: :destroy
  has_many :notices,     as: :noticeable,   dependent: :destroy


  has_many :votes,       as: :votable, dependent: :destroy
  has_many :blog_attachments, dependent: :destroy

  accepts_nested_attributes_for :blog_attachments
end
