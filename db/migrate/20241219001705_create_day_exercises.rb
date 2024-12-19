class CreateDayExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :day_exercises do |t|
      t.references :day, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :sets
      t.integer :reps
      t.decimal :weight
      t.decimal :duration

      t.timestamps
    end
  end
end
