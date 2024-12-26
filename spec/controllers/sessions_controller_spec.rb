# spec/controllers/sessions_controller_spec.rb
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  # Загружаем фикстуры из файла users.yml
  fixtures :users

  describe 'GET #new' do
    context 'when user is not logged in' do
      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'when user is already logged in' do
      it 'redirects to the home page' do
        # Авторизуем пользователя
        session[:user_id] = users(:john_doe).id
        get :new
        expect(response).to redirect_to(home_path)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'logs the user in and redirects to the home page' do
        post :create, params: { username: 'john_doe', password: 'password123' }
        expect(session[:user_id]).to eq(users(:john_doe).id)
        expect(response).to redirect_to(home_path)
      end
    end

    context 'with invalid credentials' do
      it 'renders the new template and shows an error message' do
        post :create, params: { username: 'john_doe', password: 'wrongpassword' }
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq('Неверное имя пользователя или пароль.')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'logs the user out and redirects to the home page' do
      session[:user_id] = users(:john_doe).id
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(home_path)
    end
  end
end
