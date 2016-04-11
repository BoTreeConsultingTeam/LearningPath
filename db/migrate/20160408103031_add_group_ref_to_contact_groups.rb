class AddGroupRefToContactGroups < ActiveRecord::Migration
  def change
    add_reference :contact_groups, :group, index: true
  end
end
