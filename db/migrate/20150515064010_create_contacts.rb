class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.integer :user_id
      t.integer :group_id
      t.timestamps
    end
  end
end
