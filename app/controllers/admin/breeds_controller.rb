class Admin::BreedsController < AdminController

  def index
    @breeds_dog = Breed.where(breed_type:"dog")
    @breeds_cat = Breed.where(breed_type:"cat")
    @breed = Breed.new
  end

  def create
    @breed = Breed.create(breed_params)
    redirect_to admin_breeds_path
  end

  def edit
    @breed = Breed.find(params[:id])
  end

  def update
    @breed = Breed.find(params[:id])
    @breed.update_attributes!(breed_params)
    redirect_to admin_breeds_path
  end

end
