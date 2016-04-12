class Review < ActiveRecord::Base

  include Votable

  validates :title, presence: true, length: { minimum: 4, maximum: 65 }
  validates :body,  presence: true, length: { minimum: 200, maximum: 15000 }

  after_save :set_main

  belongs_to :user
  belongs_to :breed, counter_cache: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :review_attachments, dependent: :destroy
  has_many :votes,       as: :votable, dependent: :destroy

  def avatar
    if self.review_attachments.count > 0
      self.review_attachments.sample.file
    else
      "default.jpg"
    end
  end

  private

  def set_main
    if self.review_attachments.count > 0
      self.review_attachments.first.update(main:true)
    end
  end



end
