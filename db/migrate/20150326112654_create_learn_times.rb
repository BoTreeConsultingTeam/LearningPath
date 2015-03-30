class CreateLearnTimes < ActiveRecord::Migration
  def change
    create_table :learn_times do |t|

      t.timestamps
    end
  end
end
