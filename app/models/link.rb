class Link < ActiveRecord::Base
  self.per_page = 20
  acts_as_taggable
  validates :title, :status, :category, :url, :tag_list, presence: true
  validates :url, format: { with: URI::regexp(%w(http https))
  }
  has_many :favourites
  belongs_to :user

  def create_favourite(user_id, link_id)
    favourites.create!(user_id: user_id, link_id: link_id)
  end

  def destroy_favourite(favourite)
    favourite.destroy_all
  end
end
