class ContactsController < ApplicationController
  before_filter :user_contact, only: [:update, :edit, :destroy]
  def index
    @contacts = current_user.contacts
    @contact = Contact.new unless @contact.present?
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @contact = Contact.new(contact_params.merge({ user_id: current_user.id}))
    if @contact.save
      flash[:success] = "New Contact created Successfully"
      redirect_to contacts_path
    else
      flash[:danger] = "Something went wrong"
      render 'index'
    end
  end

  def destroy
    if @contact.destroy
      flash[:success] = ["Contact Removed Successfully"]
      redirect_to contacts_path
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @contact.present?
      @contact.update(contact_params.merge({user_id: current_user.id}))
      flash[:success] = 'Successfully Updated!!'
      redirect_to contacts_path
    else
      flash.now[:danger] = 'Something went wrong'
      render 'index'
    end
  end

  private

  def user_contact
    @contact = Contact.find(params[:id])
  end
  def contact_params
    params.require(:contact).permit(:name)
  end
end
