Rails.application.routes.draw do
  devise_for :users
  devise_for :clients, skip: :all
  devise_for :admins, skip: :all

  devise_scope :user do
    authenticated :user do
      root to: redirect('/admin')
    end

    unauthenticated :user do
      root to: 'public#home', as: :unauthenticated_root
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        sessions: 'api/v1/auth/sessions',
        passwords: 'api/v1/auth/passwords',
        token_validations: 'api/v1/auth/token_validations'
      }

      resources :users, only: [:index, :show, :update, :destroy]
      mount ActionCable.server => '/cable'
    end
  end

  get 'home', to: 'public#home'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # get '/api' => redirect('/api/swagger-ui/dist/index.html?url=/api/v1/apidocs')
end
