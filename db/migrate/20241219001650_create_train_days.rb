class CreateTrainDays < ActiveRecord::Migration[8.0]
  def change
    unless table_exists?(:train_days)
      create_table :train_days do |t|
        t.references :schedule, null: false, foreign_key: true
        t.string :day_of_week

        t.timestamps
      end
    end
  end
end
