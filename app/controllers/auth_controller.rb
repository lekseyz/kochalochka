class AuthController < ApplicationController
  # Вход
  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id)
      render json: { token: token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  # Получение данных текущего пользователя
  def me
    token = request.headers['Authorization']&.split(' ')&.last
    payload = JwtService.decode(token)
    user = User.find(payload['user_id'])
    render json: user
  rescue
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
