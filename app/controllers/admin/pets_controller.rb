class Admin::PetsController < AdminController

  def index
    @pets = Mypet.order('created_at desc')
  end

  def approve
    @pet = Mypet.find(params[:admin_pet_id])
    @pet.update(approve:true)
    redirect_to admin_pets_path
  end

  def destroy
    @pet = Mypet.find(params[:id])
    @pet.destroy
    redirect_to admin_pets_path
  end

end
