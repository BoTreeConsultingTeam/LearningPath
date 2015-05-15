require 'csv'
class Link < ActiveRecord::Base
  self.per_page = 20
  acts_as_taggable
  validates :title, presence: true
  validates :url, format: { with: URI::regexp(%w(http https)) }
  has_many :favourites
  belongs_to :user
  has_many :learn_time
  belongs_to :category
  belongs_to :learning_status
  belongs_to :link_type

  scope :order_by_created_at, -> { order(:created_at => :asc) }

  scope :order_by_updated_at, -> { order(:updated_at => :asc) }

  def create_favourite(user_id, link_id)
    favourites.create!(user_id: user_id, link_id: link_id)
  end

  def destroy_favourite(favourite)
    favourite.destroy_all
  end

  def self.import(file, current_user)
    CSV.foreach(file.path, headers: true) do |row|
      find_or_create(row.to_hash.merge!(user_id: current_user.id), current_user)
    end
  end

  def self.find_or_create(hash, current_user)
    @link = self.where('user_id = ? AND url = ?  ', current_user.id, hash['url'])
    if @link.empty?
      without_taglist = hash.except('tag_list')
      @link = self.create! without_taglist
      current_user.tag(@link, :with => hash['tag_list'], :on => :tags)
    end
  end
end
