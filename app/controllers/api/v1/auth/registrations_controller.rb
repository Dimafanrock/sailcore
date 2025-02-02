module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        include Api::V1::Concerns::ErrorHandler

        def create
          generated_password = User.generate_secure_password

          @current_api_v1_user = Client.create!(sign_up_params.merge(
                                                  password: generated_password,
                                                  password_confirmation: generated_password
                                                ))

          @current_api_v1_user.send_password_email(generated_password)
          @token = TokenService.generate_for(@current_api_v1_user)

          sign_in(@current_api_v1_user)
          render_create_success
        end

        private

        def render_create_success
          render 'api/v1/clients/show'
        end

        def sign_up_params
          params.require(:user).permit(:email, :name, :nickname, :image)
        end
      end
    end
  end
end
