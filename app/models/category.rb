class Category < ActiveRecord::Base
  include PgSearch
  has_one :link
end
