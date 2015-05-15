class RemoveIndexInContactGroups < ActiveRecord::Migration
  def change
    remove_index :contacts_groups, :column => [:contact_id, :group_id]

  end
end
