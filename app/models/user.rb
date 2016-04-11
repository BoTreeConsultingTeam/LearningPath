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

  def self.get_all_link(user, date)
    user.links.where("created_at >= ?", date).group('date(created_at)').count
  end

  def favourite_links
    self.links.where(favourite: true)
  end

  def current_user_links
    self.links
  end
end
