class Cron < ActiveRecord::Base

  def recalculate_repa
    User.where(bot: false).each do |user|
      user.repa_total = user.repa + user.repa_total
      user.repa = 0
      user.save
    end
  end

end
