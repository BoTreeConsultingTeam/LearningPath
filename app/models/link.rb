class Link < ActiveRecord::Base
  acts_as_taggable
  validates :title, :status, :category, :url, :tag_list, presence: true
  validates :url, format: { with: URI::regexp(%w(http https))
  }
end
