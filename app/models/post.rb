class Post < ActiveRecord::Base

  after_create :touch_topic

  belongs_to :user
  belongs_to :topic
  validates :body, presence: true

  def touch_topic
    self.topic.touch(:updated_at)
  end

end
