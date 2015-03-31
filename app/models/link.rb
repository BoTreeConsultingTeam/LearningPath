class Link < ActiveRecord::Base
  self.per_page = 20
  acts_as_taggable
  validates :title, :learning_status_id, :category_id, :url, presence: true
  validates :url, format: { with: URI::regexp(%w(http https)) }
  has_many :favourites
  belongs_to :user
  has_many :learn_time
  belongs_to :category
  belongs_to :learning_status

  def self.learn_time(user)
    LearnTime.create!(user_id: user.id, link_id: self.id)
  end

  def create_favourite(user_id, link_id)
    favourites.create!(user_id: user_id, link_id: link_id)
  end

  def destroy_favourite(favourite)
    favourite.destroy_all
  end
end
