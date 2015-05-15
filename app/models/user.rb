class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_tagger
  
  attr_accessor :current_password
  has_many :favourites
  has_many :links
  has_many :learn_time
  has_many :contacts
  has_many :groups

  def total_links_after(date)
    links.where("created_at >= ?", date).group('date(created_at)').count
  end

  def favourite_links
    links.where(favourite: true)
  end

  def user_tag_cloud
    owned_tags
  end
end
