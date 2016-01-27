class Admin::CitiesController < AdminController

  def index
    @city   = City.new
    @countries = Country.all
  end

  def create
    @city = City.create(city_params)
    redirect_to admin_cities_path
  end

  def show
    @city = City.find(params[:id])
  end

end
