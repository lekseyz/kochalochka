class User < ApplicationRecord
  has_one :train_schedule
  has_many :progresses
  # Валидации
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
  validates :weight, presence: true
  validates :height, presence: true
  validates :birth_day, presence: true
  validates :goal, presence: true
  validates :sex, presence: true

  # Хэширование пароля
  has_secure_password

  private

  # Условие для проверки пароля
  def password_required?
    new_record? || password.present?
  end
end
