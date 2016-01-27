class Topic < ActiveRecord::Base

  belongs_to :user
  has_many   :posts, dependent: :destroy
  validates :title, presence: true, length: { minimum: 4, maximum: 65 }
  validates :body,  presence: true

end
