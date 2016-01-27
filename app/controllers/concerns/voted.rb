module Voted
  extend ActiveSupport::Concern

  included do
    before_action :get_votable, only: [:vote]
  end

  def vote
    @votable.voted_by(current_user)
  end

  private

  def get_votable
    @votable = controller_name.classify.constantize.find(params[:id])
  end

end