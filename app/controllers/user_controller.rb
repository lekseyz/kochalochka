class UsersController < ApplicationController
  # Регистрация пользователя
  def register
    Rails.logger.info "Attempting to register user with params: #{user_params.inspect}"
    user = User.new
    if user.save
      Rails.logger.info "User registered successfully: #{user.id}"
      render json: { id: user.id, username: user.username }, status: :created
    else
      Rails.logger.error "User registration failed: #{user.errors.full_messages.join(', ')}"
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Получение информации о пользователе
  def show
    Rails.logger.info "Fetching user with ID: #{params[:id]}"
    user = User.find(params[:id])
    render json: user
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error "User not found with ID: #{params[:id]}"
    render json: { error: 'User not found' }, status: :not_found
  end

  # Обновление данных пользователя
  def update
    Rails.logger.info "Updating user with ID: #{params[:id]} and params: #{user_params.inspect}"
    user = User.find(params[:id])
    if user.update(user_params)
      Rails.logger.info "User updated successfully: #{user.id}"
      render json: user
    else
      Rails.logger.error "Failed to update user: #{user.errors.full_messages.join(', ')}"
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Удаление пользователя
  def destroy
    Rails.logger.info "Deleting user with ID: #{params[:id]}"
    user = User.find(params[:id])
    user.destroy
    Rails.logger.info "User deleted successfully: #{params[:id]}"
    render json: { message: 'User deleted successfully' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error "User not found with ID: #{params[:id]}"
    render json: { error: 'User not found' }, status: :not_found
  end

  private

  def user_params
    params.permit(:username, :password, :weight, :height, :birth_day, :goal, :sex)
  end
end
