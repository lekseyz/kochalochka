class TrainSchedule < ApplicationRecord
  belongs_to :user
  has_many :day_exercises
end
