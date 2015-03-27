class Link < ActiveRecord::Base
  acts_as_taggable
  validates :title, :status, :category, :url, :tag_list, presence: true
  validates :url, format: { with: URI::regexp(%w(http https))
  }

  has_many :learn_time

  def self.learn_time(user)
    LearnTime.create!(user_id: user.id, link_id: self.id)
  end

end
