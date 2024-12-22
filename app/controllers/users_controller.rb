class UsersController < ApplicationController
  # Регистрация пользователя
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "Пользователь успешно зарегистрирован"
    else
      render :new
    end
  end
  def register
    Rails.logger.info "Attempting to register users with params: #{user_params.inspect}"

    user = User.new(user_params)
    if user.save
      Rails.logger.info "User registered successfully: #{user.id}"
      redirect_to user_path(@user), notice: 'User registered successfully!'
    else
      Rails.logger.error "User registration failed: #{user.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  # Получение информации о пользователе
  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to new_user_registration_path, alert: 'User not found'
  end

  # Обновление данных пользователя
  def update
    Rails.logger.info "Updating users with ID: #{params[:id]} and params: #{user_params.inspect}"

    user = User.find_by(id: params[:id])
    if user.nil?
      Rails.logger.error "User not found with ID: #{params[:id]}"
      render json: { error: 'User not found' }, status: :not_found
      return
    end

    if user.update(user_params)
      Rails.logger.info "User updated successfully: #{user.id}"
      render json: { message: 'User updated successfully', user: user }
    else
      Rails.logger.error "Failed to update users: #{user.errors.full_messages.join(', ')}"
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Удаление пользователя
  def destroy
    Rails.logger.info "Deleting users with ID: #{params[:id]}"

    user = User.find_by(id: params[:id])
    if user.nil?
      Rails.logger.error "User not found with ID: #{params[:id]}"
      render json: { error: 'User not found' }, status: :not_found
      return
    end

    user.destroy
    Rails.logger.info "User deleted successfully: #{params[:id]}"
    render json: { message: 'User deleted successfully' }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :weight, :height, :birth_day, :goal, :sex)
  end
end
