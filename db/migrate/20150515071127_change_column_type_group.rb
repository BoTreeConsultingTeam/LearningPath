class ChangeColumnTypeGroup < ActiveRecord::Migration
  def up
    remove_column :groups, :user_id, :string
    add_column :groups, :user_id, :integer
  end
end
