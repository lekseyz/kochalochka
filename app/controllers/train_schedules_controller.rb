class TrainSchedulesController < ApplicationController

  def index
    exercises = Exercise.joins(exercise_schedules: :train_schedule)
                        .joins("JOIN users ON users.id = train_schedules.user_id")
                        .where("users.id = ?", params[:user_id])
                        .select("exercise_schedules.day_of_week, exercises.name")

    exercises_by_day = exercises.group_by(&:day_of_week)

    all_days = %w[monday tuesday wednesday thursday friday saturday sunday]

    @exercises_by_day = all_days.index_with { |day| exercises_by_day[day] || [] }

    @user = User.find(params[:user_id])
    @all_exercises = Exercise.all
  end

  def create
    Rails.logger.info "Creating train schedule for users ID: #{params[:user_id]} with days: #{params[:days].inspect}"
    schedule = TrainSchedule.new(params[:user_id])
    schedule.save
  end

  # Получение расписания
  def show
    Rails.logger.info "Fetching train schedule with ID: #{params[:id]}"
    schedule = TrainSchedule.find(params[:id])
    render json: schedule.as_json(include: { train_days: { include: { day_exercises: { include: :exercise } } } })
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error "Train schedule not found with ID: #{params[:id]}"
    render json: { error: "Train schedule not found" }, status: :not_found
  end

  # Обновление расписания
  def update
    Rails.logger.info "Updating train schedule for user with ID: #{params[:user_id]}, day: #{params[:day_of_week]}, exercise: #{params[:exercise_id]}"

    user = User.find(params[:user_id])
    train_schedule = user.train_schedule

    exercise_schedule = ExerciseSchedule.find_or_initialize_by(
      train_schedule_id: train_schedule.id,
      day_of_week: params[:day_of_week]
    )

    exercise_schedule.exercise_id = params[:exercise_id]

    if exercise_schedule.save
      flash[:notice] = "Schedule updated successfully."
    else
      flash[:alert] = "Failed to update the schedule."
    end
  end

  # Удаление расписания
  def destroy
    Rails.logger.info "Deleting train schedule with ID: #{params[:id]}"
    schedule = TrainSchedule.find(params[:id])
    schedule.destroy
    Rails.logger.info "Train schedule deleted successfully: #{params[:id]}"
    render json: { message: "Schedule deleted successfully" }, status: :ok
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error "Train schedule not found with ID: #{params[:id]}"
    render json: { error: "Train schedule not found" }, status: :not_found
  end
end
