class BreedsController < ApplicationController
  
  def show
    @breed = Breed.find_by_translate(params[:translate])
  end
  
  def index_dogs
    @breeds_dog = Breed.where("breed_type = ?", "dog")
  end
    
  def index_cats
    @breeds_cat = Breed.where("breed_type = ?", "cat")
  end
  
end
