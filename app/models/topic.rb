class Topic < ActiveRecord::Base

  validates :title, presence: true, length: { minimum: 4, maximum: 65 }
  validates :body,  presence: true
  belongs_to :user
  has_many   :posts, dependent: :destroy
  has_many   :subscribers, as: :subscribable, dependent: :destroy
  has_many   :notices,     as: :noticeable,   dependent: :destroy


end
