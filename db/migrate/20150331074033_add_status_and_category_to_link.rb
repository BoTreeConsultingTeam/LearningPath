class AddStatusAndCategoryToLink < ActiveRecord::Migration
  def change
    add_column :links, :category_id, :integer
    add_column :links, :learning_status_id, :integer
    remove_column :links, :status
    remove_column :links, :category
  end
end
