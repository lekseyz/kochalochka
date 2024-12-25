class RenameTypeColumnInExercises < ActiveRecord::Migration[8.0]
  def change
    rename_column :exercises, :type, :exercise_type
  end
end
