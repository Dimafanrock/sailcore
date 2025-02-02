module Users
  class SessionsController < Devise::SessionsController
    before_action :check_if_client

    def after_sign_in_path_for(resource)
      resource.admin? ? avo.root_path : root_path
    end

    def after_sign_out_path_for(_resource)
      new_user_session_path
    end

    private

    def check_if_client
      return unless params[:user]&.dig(:email)

      user = User.find_by(email: params[:user][:email])
      return unless user&.client?

      flash[:alert] = "Access Denied. Clients cannot log in here."
      redirect_to new_user_session_path
    end
  end
end
