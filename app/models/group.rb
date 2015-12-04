class Group < ActiveRecord::Base

  validates :name,  presence: true
  belongs_to :user
  has_and_belongs_to_many :contacts
end
