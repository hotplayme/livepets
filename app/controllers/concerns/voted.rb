module Voted
  extend ActiveSupport::Concern

  included do
    before_action :get_votable, only: [:vote]
  end

  def vote
    if params[:vote].present?
      if params[:vote].to_i > 5
        score = 5
      else
        score = params[:vote]
      end
    else
      score = nil
    end
    @votable.voted_by(current_user, score)
  end

  private

  def get_votable
    @votable = controller_name.classify.constantize.find(params[:id])
  end

end