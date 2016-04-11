class AddGroupRefToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :group, index: true
  end
end
