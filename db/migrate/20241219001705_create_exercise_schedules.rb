class CreateExerciseSchedules < ActiveRecord::Migration[8.0]
  def change
      create_table :exercise_schedules do |t|
        t.references :train_schedule, null: false, foreign_key: true
        t.references :exercise, null: false, foreign_key: true
        t.string :day_of_week
        t.timestamps
      end
  end
end
