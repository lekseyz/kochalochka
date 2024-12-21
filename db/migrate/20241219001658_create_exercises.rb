class CreateExercises < ActiveRecord::Migration[8.0]
  def change
    unless table_exists?(:exercises)
      create_table :exercises do |t|
        t.string :link
        t.string :name
        t.string :muscle_group
        t.string :type

        t.timestamps
      end
    end
  end
end
