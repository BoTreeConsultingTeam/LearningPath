class AddContactRefToGroups < ActiveRecord::Migration
  def change
    add_reference :groups, :contact, index: true
  end
end
