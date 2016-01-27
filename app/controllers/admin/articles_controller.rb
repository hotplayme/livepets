class Admin::ArticlesController < AdminController

  def index
    @articles = Article.order("created_at DESC")
    @article  = Article.new
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(article_params)
    require 'securerandom'
    @article.randid = SecureRandom.hex(5)
    @article.save
    redirect_to admin_articles_path
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes!(article_params)
    redirect_to admin_article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_article_path
  end

end
