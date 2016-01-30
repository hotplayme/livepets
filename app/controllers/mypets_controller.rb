class MypetsController < ApplicationController
  include Voted

  def new
    if current_user.mypets.count > 3
      redirect_to im_path
    else
      @pet = Mypet.new
      @breeds = Breed.where(breed_type:'dog')
    end
  end
  
  def create
    pet = current_user.mypets.new(pet_params)
    if pet.save
      #разослать уведомления о новом питомце подписчикам данной породы
      pet.breed.subscribers.where.not(user:current_user).each do |s|
        # создаем уведомление каждому подписчику
        pet.notices.create(user: s.user)
      end
      redirect_to edit_mypet_path(pet)
    else
      flash.now[:notice] = 'Не верно заполнено поле'
      @pet = Mypet.new
      @breeds = Breed.where(breed_type:'dog')
      render 'new'
    end
  end

  def edit
    @pet = Mypet.find(params[:id])
    if current_user == @pet.user
      @breeds = Breed.all
    else
      redirect_to root_path
    end
  end

  def update
    @pet = Mypet.find(params[:id])
    if current_user == @pet.user
      if breed = Breed.find_by_name(params[:mypet][:breed_id])
        @pet.update(pet_params)
        @pet.breed_id = breed.id
        @pet.save
        if params[:images]
          params[:images].each do |image|
            @pet.pet_attachments.create(file:image, main:"#{ @pet.pet_attachments.count == 0 ? "true" : "false" }")
          end
        end
        redirect_to edit_mypet_path(@pet)
      else
        flash[:notice] = "Правильно выберите породу"
        render :action => 'edit'
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @pet = Mypet.find(params[:id])
    if current_user == @pet.user
      @pet.destroy
      redirect_to user_path(current_user.nickname)
    else
      redirect_to root_path
    end
  end

  def do_main
    @attachment = PetAttachment.find(params[:id])
    @pet = @attachment.mypet
    if @pet.user == current_user
      @pet.pet_attachments.update_all(main:false)
      @attachment.update(main:true)
    else
      redirect_to root_path
    end
  end

  def a_delete
    @attachment = PetAttachment.find(params[:id])
    @pet = @attachment.mypet
    if @pet.user == current_user
      if @attachment.main
        @attachment.destroy
        @pet.pet_attachments.first.update(main:true) if @pet.pet_attachments.count > 0
      else
        @attachment.destroy
      end
    else
      redirect_to root_path
    end
  end

  def update_breeds
    @breeds = Breed.where("breed_type = ?", params[:breed_type])
    respond_to do |format|
      format.js
      format.html
    end
  end

  private
  def pet_params
    params.require(:mypet).permit(:name, :sex, :photo, :birthday, :breed_id)
  end
end
