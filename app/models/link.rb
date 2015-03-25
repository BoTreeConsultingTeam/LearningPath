class Link < ActiveRecord::Base
  validates :title, :status, :category, :url, presence: true
  validates :url, format: { with: URI::regexp(%w(http https))
  }
end
