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

  def image_create
    params[:mypet][:pet_attachment].each do |file|
      @file = current_user.pet_attachments.create(file: file)
    end
  end
  
  def create
    pet = current_user.mypets.build(pet_params)
    if pet.save
      # создание картинок, если они есть
      if params[:attach_ids].present?
        PetAttachment.where(id: params[:attach_ids]).update_all(mypet_id: pet.id)
        pet.pet_attachments.first.update(main:true)
      end
      pet.pet_attachments_count = pet.pet_attachments.count
      pet.save
      #разослать уведомления о новом питомце подписчикам данной породы
      pet.breed.subscribers.where.not(user:current_user).each do |s|
        # создаем уведомление каждому подписчику
        pet.notices.create(user: s.user)
      end
      redirect_to user_path(current_user.nickname.downcase)
    else
      render 'new'
    end
  end

  def edit
    @pet = Mypet.find(params[:id])
    if current_user == @pet.user
      @breeds = Breed.where(breed_type: @pet.breed.breed_type)
    else
      redirect_to root_path
    end
  end

  def update
    @pet = Mypet.find(params[:id])
    if current_user == @pet.user
      if params[:attach_ids].present?
        PetAttachment.where(id: params[:attach_ids]).update_all(mypet_id: @pet.id)
        if @pet.pet_attachments.where(main: true).count == 0
          @pet.pet_attachments.first.update(main:true)
        end
      end
      if @pet.update(pet_params.merge(approve: false))
        @pet.pet_attachments_count = @pet.pet_attachments.count
        @pet.save
        redirect_to user_path(@pet.user.nickname.downcase)
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
    if @attachment.user == current_user
      if @attachment.main
        @pet = @attachment.mypet
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
