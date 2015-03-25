class LinksController < ApplicationController
  before_filter :assign_link, only: [:update, :destroy, :edit]

  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
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

  private
    def link_params
      params.require(:link).permit(:title, :url, :status, :description, :category)
    end

    def assign_link
      @link = Link.find(params[:id])
    end
end
