class WriterController < ApplicationController

  include ActionView::Helpers::SanitizeHelper

  before_action :check_writer

  def index
    @payed_blogs = current_user.blogs.where(payed: true).order("created_at DESC")
    @not_payed_blogs = current_user.blogs.where(payed: false).order("created_at DESC")
  end

  private

  def check_writer
    redirect_to root_path unless current_user && current_user.writer
  end

end
