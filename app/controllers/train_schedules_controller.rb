class TrainSchedulesController < ApplicationController
  # Создание расписания
  def create
    Rails.logger.info "Creating train schedule for user ID: #{params[:user_id]} with days: #{params[:days].inspect}"
    schedule = TrainSchedule.new
    if schedule.save
      params[:days].each do |day|
        train_day = schedule.train_days.create!(day_of_week: day[:day_of_week])
        day[:exercises].each do |exercise|
          train_day.day_exercises.create!(exercise_id: exercise[:exercise_id], sets: exercise[:sets], reps: exercise[:reps], weight: exercise[:weight])
        end
      end
      Rails.logger.info "Train schedule created successfully: #{schedule.id}"
      render json: { id: schedule.id, user_id: schedule.user_id }, status: :created
    else
      Rails.logger.error "Failed to create train schedule: #{schedule.errors.full_messages.join(', ')}"
      render json: { errors: schedule.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Получение расписания
  def show
    Rails.logger.info "Fetching train schedule with ID: #{params[:id]}"
    schedule = TrainSchedule.find(params[:id])
    render json: schedule.as_json(include: { train_days: { include: { day_exercises: { include: :exercise } } } })
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error "Train schedule not found with ID: #{params[:id]}"
    render json: { error: 'Train schedule not found' }, status: :not_found
  end

  # Обновление расписания
  def update
    Rails.logger.info "Updating train schedule with ID: #{params[:id]} and days: #{params[:days].inspect}"
    schedule = TrainSchedule.find(params[:id])
    schedule.train_days.destroy_all
    params[:days].each do |day|
      train_day = schedule.train_days.create!(day_of_week: day[:day_of_week])
      day[:exercises].each do |exercise|
        train_day.day_exercises.create!(exercise_id: exercise[:exercise_id], sets: exercise[:sets], reps: exercise[:reps], weight: exercise[:weight])
      end
    end
    Rails.logger.info "Train schedule updated successfully: #{schedule.id}"
    render json: { message: 'Schedule updated successfully' }
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error "Train schedule not found with ID: #{params[:id]}"
    render json: { error: 'Train schedule not found' }, status: :not_found
  end

  # Удаление расписания
  def destroy
    Rails.logger.info "Deleting train schedule with ID: #{params[:id]}"
    schedule = TrainSchedule.find(params[:id])
    schedule.destroy
    Rails.logger.info "Train schedule deleted successfully: #{params[:id]}"
    render json: { message: 'Schedule deleted successfully' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error "Train schedule not found with ID: #{params[:id]}"
    render json: { error: 'Train schedule not found' }, status: :not_found
  end
end
