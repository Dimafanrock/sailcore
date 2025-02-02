module Api
  module V1
    module Auth
      class SessionsController < DeviseTokenAuth::SessionsController
        include Api::V1::Concerns::ErrorHandler

        def create
          user = User.find_by(email: params[:email])
          raise AuthenticationErrors::InvalidTokenError, I18n.t('errors.auth.invalid_credentials') unless user&.valid_password?(params[:password])

          @current_api_v1_user = user
          @token = TokenService.generate_for(user)

          render 'api/v1/clients/show'
        end
      end
    end
  end
end
