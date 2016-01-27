class Winner < ActiveRecord::Base

  belongs_to :user

  def self.create_winner
    user = User.order('repa desc').first
    user.winners.create(score: user.repa)
    User.where("repa > 0").update_all("repa_total = repa_total + repa, repa = 0")
  end

end
