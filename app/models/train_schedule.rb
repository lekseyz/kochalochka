class TrainSchedule < ApplicationRecord
  belongs_to :user
  has_many :exercise_schedules
  has_many :exercises, through: :exercise_schedules
end
