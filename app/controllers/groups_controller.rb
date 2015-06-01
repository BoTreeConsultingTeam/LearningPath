class GroupsController < ApplicationController
  before_filter :user_group, only: [:show, :update, :edit, :destroy]
  
  def index
    @groups = current_user.groups
    @group = Group.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @group = Group.new(group_params.merge({ user_id: current_user.id}))
    if @group.save
      flash[:success] = "New Group created Successfully"
      redirect_to groups_path
    else
      flash[:danger] = "Something went wrong"
      render 'index'
    end
  end

  def show
    @contacts = @group.contacts
    @all_contacts = current_user.contacts - @contacts
  end

  def destroy
    if @group.destroy
      flash[:success] = ["Contact Removed Successfully"]
      redirect_to groups_path
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @group.present?
      @group.update(group_params.merge({user_id: current_user.id}))
      flash[:success] = 'Successfully Updated!!'
      redirect_to groups_path
    else
      flash.now[:danger] = 'Something went wrong'
      render 'index'
    end
  end

  def add_member
    @contact_group = ContactsGroups.new(contact_id: params[:contact_id], group_id: params[:id])
    if @contact_group.save
      flash[:success] = ["Contact Added to Group"]
      redirect_to group_path(params[:id])
    end
  end

  def remove_member
    @contact_group = ContactsGroups.where(contact_id: params[:contact_id], group_id: params[:group_id])
    if @contact_group.first.destroy
      flash[:success] = ["Contact Removed Successfully"]
      redirect_to group_path(params[:group_id])
    end
  end

  private
    def user_group
      @group = Group.find_by_id(params[:id])
    end

    def group_params
      params.require(:group).permit(:name)
    end
end