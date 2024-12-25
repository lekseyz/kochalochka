class ApplicationController < ActionController::Base
  def authenticate_user!
    unless current_user
      redirect_to login_path, alert: "Пожалуйста, войдите в систему."
    end
  end

  # Метод для получения текущего пользователя из сессии
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:error] = "Требуется вход в систему."
      redirect_to login_path
    end
  end
end