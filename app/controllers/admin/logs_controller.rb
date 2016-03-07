class Admin::LogsController < AdminController

  def show
    @log = `tail -n #{5000} /home/rails/shared/log/production.log`
    @log = @log.gsub(/\n/, "<br>")
  end

  def clear
    system("cp /dev/null /home/rails/log/production.log")
    redirect_to log_admin_index_path
  end

end
