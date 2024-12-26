class Exercise < ApplicationRecord
  validates :name, presence: true
  validates :exercise_type, presence: true, inclusion: { in: %w[strength stretch cardio] }
  has_many :exercise_schedules
  has_many :train_schedules, through: :exercise_schedules
end
