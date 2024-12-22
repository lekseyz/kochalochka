# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new]
  # Действие для отображения формы входа
  def new

  end

  # Действие для обработки логина
  def create
    @user = User.find_by(username: params[:username])

    # Проверка пользователя и пароля
    if @user && @user.authenticate(params[:password])
      # Сохраняем пользователя в сессии
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Добро пожаловать, #{@user.username}!"
    else
      # Если логин или пароль неправильные, показываем ошибку
      flash.now[:alert] = 'Неверное имя пользователя или пароль.'
      render :new # Повторно показываем форму входа
    end
  end

  # Действие для выхода пользователя
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Вы вышли из системы.'
  end
  private
  def require_logged_out
    if current_user
      redirect_to home_path  # Если пользователь уже вошел, перенаправляем его на главную
    end
  end
end
