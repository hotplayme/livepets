class ReviewsController < ApplicationController

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
      fdfredirect_to reviews_path, status: 301
    end
  end



  def create
    @review = current_user.reviews.create(review_params)
    if params[:images]
      params[:images].each do |image|
        @review.review_attachments.create(file:image)
      end
    end
    @review.save
    redirect_to reviews_path
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :breed_id)
  end


end
