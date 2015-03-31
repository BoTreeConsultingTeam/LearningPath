class AddLinkTypeIdtoLinks < ActiveRecord::Migration
  def change
    add_column :links, :link_type_id, :integer
  end
end
