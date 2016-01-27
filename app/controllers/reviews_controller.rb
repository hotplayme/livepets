class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
    @breeds = Breed.where(breed_type:'dog')
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
