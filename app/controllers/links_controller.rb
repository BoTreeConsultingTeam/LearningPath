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
      format.js
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
    if params[:file]
      Link.import(params[:file], current_user)
       flash[:notice] =  "Links imported."
    else
      flash[:danger] = "Please specify file name."
    end
    redirect_to root_url
  end

  def list_selected
    @id_arr = params['link_ids'].map(&:to_i)
    @selected_links = Link.find(@id_arr)
    @contacts = current_user.contacts.paginate(:page       => params[:page],
                                               :per_page   => 10,
    )

    @groups = current_user.groups
    respond_to do |format|
      format.js
    end
  end

  def remove_selected
    id_arr = params['links']
    Link.destroy(id_arr)
    flash[:success] =  "Links Removed."
    respond_to do |format|
      format.js { redirect_to links_path }
    end
  end

  def send_links
    LinkMailer.share_by_email(params[:name], 'hi this is my subject').deliver
    redirect_to links_path
    # to be implement
  end

  def final_sender
    @id_arr = eval(params['links'])[:value]
    @links = Link.find(@id_arr)
    @contact_emails, @groups_contacts_emails = [], []
    @contact_emails = Contact.find(params[:contact_ids]).map{|c|c.email} unless params[:contact_ids].nil?
    @groups_contacts_emails = Group.find(params[:group_ids]).map{|gr|gr.contacts.pluck(:email)} unless params[:group_ids].nil?
    @email_list = @contact_emails.concat(@groups_contacts_emails)
    LinkMailer.share_by_email(@links, @email_list, 'hi this is my subject').deliver
    redirect_to links_path
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

