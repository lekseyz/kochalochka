class User < ApplicationRecord
  belongs_to :train_schedule
  # Валидации
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :weight, presence: true
  validates :height, presence: true
  validates :birth_day, presence: true
  validates :goal, presence: true
  validates :sex, presence: true


  # Хэширование пароля
  has_secure_password

  # Колбэки
  before_create :normalize_username

  private

  def normalize_username
    self.username = username.strip.downcase
  end
end
