class AddFavouriteToLink < ActiveRecord::Migration
  def change
    add_column :links, :favourite, :boolean
  end
end
