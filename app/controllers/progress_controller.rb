class ProgressController < ApplicationController
  # Добавление прогресса
  def create
    Rails.logger.info "Creating progress with params: #{progress_params.inspect}"
    progress = Progress.new
    if progress.save
      Rails.logger.info "Progress created successfully: #{progress.id}"
      render json: progress, status: :created
    else
      Rails.logger.error "Failed to create progress: #{progress.errors.full_messages.join(', ')}"
      render json: { errors: progress.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Получение прогресса по пользователю
  def index
    Rails.logger.info "Fetching progress for users ID: #{params[:user_id]}"
    progresses = Progress.where(user_id: params[:user_id])
    render json: progresses.as_json(include: :exercise)
  end

  # Удаление записи о прогрессе
  def destroy
    Rails.logger.info "Deleting progress with ID: #{params[:id]}"
    progress = Progress.find(params[:id])
    progress.destroy
    Rails.logger.info "Progress deleted successfully: #{params[:id]}"
    render json: { message: 'Progress deleted successfully' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error "Progress not found with ID: #{params[:id]}"
    render json: { error: 'Progress not found' }, status: :not_found
  end

  private

  def progress_params
    params.permit(:user_id, :exercise_id, :date, :type, :reps, :weight, :duration, :intensity)
  end
end
