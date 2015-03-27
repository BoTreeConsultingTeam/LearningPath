class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :user_id
      t.integer :link_id
      t.timestamps
    end
    add_index "favourites", ["user_id", "link_id"], name: "favourites_index", unique: true, using: :btree
  end
end
