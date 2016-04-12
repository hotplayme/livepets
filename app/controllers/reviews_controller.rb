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
      if params[:attach_ids].present?
        ReviewAttachment.where(id: params[:attach_ids]).update_all(review_id: @review.id)
      end
      redirect_to review_show_path(@review.breed.breed_type, @review.breed.translate, @review)
    else
      render :new
    end
  end

  def show
    if @review = Review.find_by_id(params[:id])
      redirect_to review_show_path(@review.breed.breed_type, @review.breed.translate, @review) if params[:breed_translate] != @review.breed.translate || params[:breed_type] != @review.breed.breed_type
      @score = (@review.votes.sum(:score).to_f/@review.votes.count).round(1)
    else
      redirect_to reviews_path, status: 301
    end
  end

  def edit
    if @review = Review.find_by_id(params[:id])
      if current_user && @review.user == current_user
        @breeds = Breed.where(breed_type: @review.breed.breed_type)
      else
        redirect_to reviews_path
      end
    else
      redirect_to reviews_path
    end
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

  def image_create
    params[:review][:review_attachments].each do |file|
      @file = ReviewAttachment.create(file: file, user_id: current_user.id)
    end
  end

  def a_delete
    @attachment = ReviewAttachment.find(params[:id])
    @attachment.destroy if @attachment.user_id == current_user.id
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :breed_id)
  end


end
