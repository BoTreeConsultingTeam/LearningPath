class LinksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :assign_link, only: [:update, :destroy, :edit]
  before_filter :all_tags, only: [ :edit, :new ]
  def index
    selected_tag = params[:tag]
    if selected_tag
      @links = current_user_links.tagged_with(selected_tag).paginate(page: page)
    else
      @links = current_user_links.paginate(page: page)
    end
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params.merge({ user_id: current_user.id }))
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
    @links = current_user.links.where(favourite: true).paginate(page: page)
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

    def page
      @page ||= params[:page]
    end

    def current_user_links
      current_user.links
    end
end

