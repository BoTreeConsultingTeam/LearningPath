class Contact < ActiveRecord::Base
  validates :name, :email,  presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  belongs_to :user
  has_and_belongs_to_many :groups
end
