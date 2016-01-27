class ArticlesController < ApplicationController

  include Voted

  def index
    @articles = Article.where("created_at < ?", Time.now).order("created_at DESC")
  end
  
  def show
    if Article.find_by_randid(params[:id]) != nil
      @article = Article.find_by_randid(params[:id])
      @article.increment!(:views) if browser.known?
      @comment = Comment.new
    else
      redirect_to root_path, status: 301
    end
  end

end
