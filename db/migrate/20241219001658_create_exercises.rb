class CreateExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :exercises do |t|
      t.string :link
      t.string :name
      t.string :muscle_group
      t.string :type

      t.timestamps
    end
  end
end
