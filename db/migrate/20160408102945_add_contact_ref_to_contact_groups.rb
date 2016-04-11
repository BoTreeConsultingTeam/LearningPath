class AddContactRefToContactGroups < ActiveRecord::Migration
  def change
    add_reference :contact_groups, :contact, index: true
  end
end
