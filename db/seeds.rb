# Создание пользователей
user1 = User.create!(
  username: 'john_doe',
  password: 'password123',  # Используйте bcrypt для реальных паролей, здесь для примера
  password_confirmation: 'password123',
  weight: 75,
  height: 180,
  birth_day: '1990-01-01',
  goal: 'muscle-growth',
  sex: 'male'
)

user2 = User.create!(
  username: 'jane_doe',
  password: 'password456',
  password_confirmation: 'password456',
  weight: 65,
  height: 170,
  birth_day: '1992-02-02',
  goal: 'fat-loss',
  sex: 'female'
)

# Создание упражнений
exercise1 = Exercise.create!(
  name: 'Push-ups',
  muscle_group: 'Chest',
  exercise_type: 'strength'
)

exercise2 = Exercise.create!(
  name: 'Squats',
  muscle_group: 'Legs',
  exercise_type: 'strength'
)

exercise3 = Exercise.create!(
  name: 'Running',
  muscle_group: 'Cardio',
  exercise_type: 'strength'
)

# Создание расписания тренировок для пользователей
train_schedule1 = TrainSchedule.create!(user: user1)
train_schedule2 = TrainSchedule.create!(user: user2)

# Добавление упражнений в расписания
ExerciseSchedule.create!(
  train_schedule: train_schedule1,
  exercise: exercise1,
  day_of_week: 'monday'
)

ExerciseSchedule.create!(
  train_schedule: train_schedule1,
  exercise: exercise2,
  day_of_week: 'wednesday'
)

ExerciseSchedule.create!(
  train_schedule: train_schedule2,
  exercise: exercise3,
  day_of_week: 'friday'
)

# Пример прогресса
Progress.create!(
  exercise: exercise1,
  user: user1,
  date: '2024-12-25',
  type: 'strength',
  reps: 20,
  weight: 60,
  duration: nil,
  intensity: 80
)

Progress.create!(
  exercise: exercise2,
  user: user2,
  date: '2024-12-25',
  type: 'strength',
  reps: 15,
  weight: 50,
  duration: nil,
  intensity: 70
)