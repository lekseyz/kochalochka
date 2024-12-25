class ExerciseSchedule < ApplicationRecord
  belongs_to :train_schedule
  belongs_to :exercise
end
