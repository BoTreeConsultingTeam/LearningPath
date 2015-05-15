class CreateContactsGroups < ActiveRecord::Migration
  def change
    create_table :contacts_groups do |t|
      t.integer :contact_id
      t.integer :group_id
      t.timestamps
    end
    add_index :contacts_groups, [:contact_id, :group_id]
  end
end
