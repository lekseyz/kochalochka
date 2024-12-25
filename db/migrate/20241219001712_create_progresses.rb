class CreateProgresses < ActiveRecord::Migration[8.0]
  def change
      create_table :progresses do |t|
        t.references :exercise, null: false, foreign_key: true
        t.references :user, null: false, foreign_key: true
        t.date :date
        t.string :type
        t.integer :reps
        t.decimal :weight
        t.decimal :duration
        t.decimal :intensity

        t.timestamps
      end
  end
end
