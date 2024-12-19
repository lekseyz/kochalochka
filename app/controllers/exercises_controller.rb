class ExercisesController < ApplicationController
  # Добавление нового упражнения
  def create
    Rails.logger.info "Creating exercise with params: #{exercise_params.inspect}"
    exercise = Exercise.new
    if exercise.save
      Rails.logger.info "Exercise created successfully: #{exercise.id}"
      render json: { id: exercise.id, name: exercise.name }, status: :created
    else
      Rails.logger.error "Failed to create exercise: #{exercise.errors.full_messages.join(', ')}"
      render json: { errors: exercise.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Получение списка всех упражнений
  def index
    Rails.logger.info "Fetching all exercises"
    exercises = Exercise.all
    render json: exercises
  end

  # Обновление упражнения
  def update
    Rails.logger.info "Updating exercise with ID: #{params[:id]} and params: #{exercise_params.inspect}"
    exercise = Exercise.find(params[:id])
    if exercise.update(exercise_params)
      Rails.logger.info "Exercise updated successfully: #{exercise.id}"
      render json: exercise
    else
      Rails.logger.error "Failed to update exercise: #{exercise.errors.full_messages.join(', ')}"
      render json: { errors: exercise.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Удаление упражнения
  def destroy
    Rails.logger.info "Deleting exercise with ID: #{params[:id]}"
    exercise = Exercise.find(params[:id])
    exercise.destroy
    Rails.logger.info "Exercise deleted successfully: #{params[:id]}"
    render json: { message: 'Exercise deleted successfully' }, status: :ok
  end

  private

  def exercise_params
    params.permit(:name, :link, :muscle_group, :type)
  end
end
