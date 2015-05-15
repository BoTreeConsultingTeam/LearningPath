class AddIndexInContactGroups < ActiveRecord::Migration
  def change
    add_index  :contacts_groups, [:contact_id, :group_id], unique: true, using: :btree
  end
end
