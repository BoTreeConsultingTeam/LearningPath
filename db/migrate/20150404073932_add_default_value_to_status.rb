class AddDefaultValueToStatus < ActiveRecord::Migration
  def change
    change_column :links, :learning_status_id, :integer, :default => 1
  end
end
