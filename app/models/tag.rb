class Tag < ActiveRecord::Base
  include PgSearch
  multisearchable against: :name
end
