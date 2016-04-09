class ReviewsController < ApplicationController

  include Voted

  def index
    @reviews = Review.order("created_at DESC")
  end

  def new
    @review = Review.new
    @breeds = Breed.where(breed_type:'dog')
  end

  def breed_type
    if params[:breed_type] == 'dog'
      @reviews = Review.where(breed_type: 'dog')
      @breeds = Breed.where(breed_type: 'dog')
      render 'index'
    elsif params[:breed_type] == 'cat'
      @reviews = Review.where(breed_type: 'cat')
      @breeds = Breed.where(breed_type: 'cat')
      render 'index'
    else
      ffredirect_to reviews_path,status: 301
    end
  end

  def breed_translate
    if breed = Breed.find_by_translate(params[:breed_translate])
      @reviews = breed.reviews
      render 'index'
    else
      redirect_to reviews_path, status: 301
    end
  end

  def create
    @review = current_user.reviews.new(review_params.merge(breed_type: params[:breed_type]))
    if @review.save
      if params[:images]
        params[:images].each do |image|
          @review.review_attachments.create(file:image)
        end
      end
      redirect_to review_show_path(@review.breed.breed_type, @review.breed.translate, @review)
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    @score = (@review.votes.sum(:score).to_f/@review.votes.count).round(1)
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to review_show_path(@review.breed.breed_type, @review.breed.translate, @review)
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.update(del: true) if @review.user == current_user
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :breed_id)
  end


end
