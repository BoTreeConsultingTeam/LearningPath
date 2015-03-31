class CreateLearningStatuses < ActiveRecord::Migration
  def change
    create_table :learning_statuses do |t|
      t.string :status
      t.timestamps
    end
  end
end
