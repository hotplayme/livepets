class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :commentable, polymorphic:true, counter_cache: true


  validates :body, presence:true

end
