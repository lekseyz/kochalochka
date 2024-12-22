class HomeController < ApplicationController
  before_action :require_login

  def index

  end

  private

  def require_login
    unless current_user
      redirect_to root_path, alert: "Пожалуйста, войдите в систему"  # Если не авторизован, перенаправляем на логин
    end
  end
end
