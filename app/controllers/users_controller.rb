class UsersController < ApplicationController
  before_action :require_logged_in, only: [:new]
  # Регистрация пользователя
  def new
    if current_user
      redirect_to user_path(current_user)  # Перенаправляем на страницу профиля, если пользователь уже залогинен
    else
      @user = User.new
    end
  end


  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :new  # Если регистрация не удалась, показываем ошибку
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

  def require_logged_in
    if current_user
      redirect_to home_path  # Если пользователь уже авторизован, перенаправляем его на главную
    end
  end
end
