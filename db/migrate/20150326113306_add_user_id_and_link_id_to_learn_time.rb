class AddUserIdAndLinkIdToLearnTime < ActiveRecord::Migration
  def change
    add_column :learn_times, :user_id, :integer
    add_column :learn_times, :link_id, :integer
  end
end
