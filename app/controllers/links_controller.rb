class LinksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :assign_link, only: [:update, :destroy, :edit]
  before_filter :all_tags, only: [ :edit, :new ]
  def index
    if params[:tag]
      @tag = ActsAsTaggableOn::Tag.find_by_name(params[:tag])
      @links = Link.tagged_with(params[:tag])
    else
      @links = current_user.links
    end
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params.merge({ user_id: current_user.id }))
    current_user.tag(@link, :with => link_params[:tag_list], :on => :tags)

    if @link.save
      redirect_to links_path
    else
      flash[:error] = "Something went wrong"
      redirect_to new_link_path
    end
  end

  def edit
  end

  def update
    if @link.update_attributes(link_params)
    flash[:success] = 'Successfully Updated!!'
    redirect_to links_path
    else
      flash[:error] = 'Error'
      render 'edit'
    end
  end

  def destroy
    if @link.destroy
      flash[:success] = "Link Removed Successfully"
      redirect_to links_path
    end
  end

  def favourites
    @links = current_user.links.where(favourite: true)
    render 'links/index'
  end

  private
    def link_params
      params.require(:link).permit(:title, :url, :status, :description, :category, :user_id, :tag_list => [])
    end

    def assign_link
      @link = Link.find(params[:id])
    end

    def all_tags
      @tags = Tag.all
    end
end

