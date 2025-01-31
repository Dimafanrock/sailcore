module Api
  module V1
    module Auth
      class SessionsController < DeviseTokenAuth::SessionsController
        def create
          user = User.find_by(email: params[:email])

          if user&.valid_password?(params[:password])
            @current_api_v1_user = user
            @token = JsonWebToken.encode(user_id: user.id, type: user.type)

            render 'api/v1/clients/show'
          else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
          end
        end
      end
    end
  end
end
