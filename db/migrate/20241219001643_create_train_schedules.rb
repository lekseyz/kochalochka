class CreateTrainSchedules < ActiveRecord::Migration[8.0]
  def change
      create_table :train_schedules do |t|
        t.references :user, index: {:unique=>true}, null: false, foreign_key: true

        t.timestamps
    end
  end
end
