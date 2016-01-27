class Review < ActiveRecord::Base

  after_save :set_main

  belongs_to :breed
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :review_attachments, dependent: :destroy

  private

  def set_main
    if self.review_attachments.count > 0
      self.review_attachments.first.update(main:true)
    end
  end

end
