class LinksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :assign_link, only: [:update, :destroy, :edit]
  before_filter :user_specific_tags, only: [ :edit, :new, :update ]
  before_filter :all_categories, only: [ :edit, :new, :update ]
  before_filter :all_status, only: [ :edit, :new, :update ]
  before_filter :all_link_types, only: [ :edit, :new, :update ]

  def index
    selected_tag = params[:tag]
    if selected_tag
      @links = current_user_links.tagged_with(selected_tag).order(:created_at => :desc).paginate(page: page)
    else
      @links = current_user_links.order(:created_at => :desc).paginate(page: page)
    end
    respond_to do |format|
      format.html
      format.csv { send_data to_csv(current_user) }
    end
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params.merge({ user_id: current_user.id }).except!(:tag_list))
    current_user.tag(@link, :with => link_params[:tag_list], :on => :tags)

    if @link.save
      redirect_to root_path
      flash[:success] = "You have created it successfully"
    else
      flash[:danger] = @link.errors.full_messages
      redirect_to new_link_path
    end
  end

  def edit
  end

  def update
    if @link.present?
      @link.update(link_params.merge({user_id: current_user.id}).except!(:tag_list))
      current_user.tag(@link, :with => link_params[:tag_list], :on => :tags)
      flash[:success] = 'Successfully Updated!!'
      redirect_to root_path
    else
      flash.now[:danger] = @link.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    if @link.destroy
      flash[:success] = ["Link Removed Successfully"]
      redirect_to root_path
    end
  end

  def favourites
    @links = current_user.links.where(favourite: true).order(:created_at => :desc).paginate(page: page)
    render 'links/index'
  end

  def import
    file_params = params[:file]
    if file_params
      if File.extname(file_params.content_type) == "text/csv"
        Link.import(file_params, current_user)
        flash[:notice] =  "Links imported."
      else
        flash[:danger] =  "File type not matched"
      end
    else
      flash[:danger] = "Please specify file name."
    end
    redirect_to root_url
  end


  private
    def link_params
      params.require(:link).permit(:title, :url, :learning_status_id, :description, :category_id, :user_id,  :link_type_id, :tag_list => [])
    end

    def assign_link
      @link = Link.find(params[:id])
    end

    def user_specific_tags
      @tags = current_user.owned_tags
    end
    def all_categories
      @categories = Category.all
    end

    def all_link_types
      @link_types = LinkType.all
    end
    def all_status
      @statuses = LearningStatus.all
    end
    def page
      @page ||= params[:page]
    end

    def current_user_links
      current_user.links
    end

  def to_csv(user, options= {})
    column_names = Link.column_names
    column_names << 'tag_list' unless column_names.include? 'tag_list'
    column_names.delete_at(0) if column_names[0] == 'id'
    CSV.generate(options) do |csv|
      csv << column_names
      user.links.each do |link|
        arr = link.attributes.except!('id').values_at(*column_names)
        arr[-1] = link.tags.join(', ')
        csv << arr
      end
    end
  end
end

