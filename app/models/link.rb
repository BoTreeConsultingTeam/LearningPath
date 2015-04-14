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

  def self.learn_time(user)
    LearnTime.create!(user_id: user.id, link_id: self.id)
  end

  def create_favourite(user_id, link_id)
    favourites.create!(user_id: user_id, link_id: link_id)
  end

  def destroy_favourite(favourite)
    favourite.destroy_all
  end

  def self.import(file, current_user)
    CSV.foreach(file.path, headers: true) do |row|
      Link.find_or_create(row.to_hash.merge!(user_id: current_user.id), current_user)
    end
  end

  def self.find_or_create(hash, current_user)
     @link = Link.create! hash.except!(:tag_list) unless Link.find_by_id(hash['id'].to_i)
     current_user.tag(@link, :with => hash['tag_list'], :on => :tags)
  end


end
