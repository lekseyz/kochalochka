class Exercise < ApplicationRecord
  validates :name, presence: true
  validates :exercise_type, presence: true, inclusion: { in: %w[strength stretch cardio] }
end
