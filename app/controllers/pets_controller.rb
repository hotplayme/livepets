class PetsController < ApplicationController

  respond_to :html, :js

  def index
    @pets = Mypet.all
    @pets = @pets.select { |t| t.breed.breed_type == "Cat" } if params[:show_indie] && params[:show_indie] == "false"
  end

  def filter
    puts 'xxx'
  end

end
