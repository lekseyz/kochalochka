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
    if current_user.update(account_params)
      flash[:success] = "Данные аккаунта успешно обновлены."
      redirect_to root_path
    else
      flash[:error] = "Ошибка обновления данных аккаунта: #{current_user.errors.full_messages.join(', ')}"
      render :edit
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

  def account_params
    params.require(:user).permit(:weight, :height, :goal)
  end

  def require_logged_in
    if current_user
      redirect_to home_path  # Если пользователь уже авторизован, перенаправляем его на главную
    end
  end
end
