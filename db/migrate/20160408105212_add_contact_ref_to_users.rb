class AddContactRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :contact, index: true
  end
end
