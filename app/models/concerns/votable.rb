module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def voted_by(user, score)
    unless votes.where(user_id: user.id).exists?
      votes.create(user_id: user.id, score: score)
      user.increment!(:repa, 0.1)
    end
  end

end