Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount Avo::Engine, at: "/avo"
  end

  root to: 'home#index'
  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        sessions: 'api/v1/auth/sessions',
        passwords: 'api/v1/auth/passwords',
        token_validations: 'api/v1/auth/token_validations'
      }

      mount ActionCable.server => '/cable'
    end
  end

  # mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # get '/api' => redirect('/api/swagger-ui/dist/index.html?url=/api/v1/apidocs')
end
