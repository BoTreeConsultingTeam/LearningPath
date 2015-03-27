class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :current_password
  has_many :favourites
  has_many :links
  has_many :learn_time

  def self.get_all_link(user, date)
    user.links.where("created_at >= ?", date).group('date(created_at)').count
  end
end
