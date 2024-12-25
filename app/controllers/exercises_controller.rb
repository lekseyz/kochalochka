class ExercisesController < ApplicationController
  before_action :set_user

  def index
    @exercises = Exercise
                   .joins("LEFT JOIN progresses ON exercises.id = progresses.exercise_id AND progresses.user_id = #{@user.id}")
                   .select('exercises.*, MAX(progresses.date) AS last_updated, progresses.reps, progresses.weight, progresses.duration, progresses.intensity')
                   .where(id: @user.id)
                   .group('exercises.id, progresses.reps, progresses.weight, progresses.duration, progresses.intensity')
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      /
      DayExercise.create(
        day_id: params[:day_id],
        exercise_id: @exercise.id,
        sets: params[:sets],
        reps: params[:reps],
        weight: params[:weight],
        duration: params[:duration]
      )
      /
      redirect_to user_exercises_path(@user), notice: 'Exercise was successfully added.'
    else
      render :new
    end
  end

    private

    def set_user
    @user = User.find(params[:user_id])
  end

  def exercise_params
    params.require(:exercise).permit(:name, :muscle_group, :exercise_type, :link)
  end
end
