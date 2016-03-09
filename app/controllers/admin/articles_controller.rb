class Admin::ArticlesController < AdminController

  def index
    @articles = Article.order("created_at DESC")
    @article  = Article.new
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    require 'securerandom'
    @article.randid = SecureRandom.hex(5)
    @article.save
    Tag.where(id: params[:tag]).each do |tag|
      @article.tags << tag
    end
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
    @article.tags.destroy_all
    Tag.where(id: params[:tag]).each do |tag|
      @article.tags << tag
    end
    redirect_to admin_article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_article_path
  end

end
