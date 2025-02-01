module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    rescue AuthenticationError, ExpiredTokenError, InvalidTokenError
      reject_unauthorized_connection
    end

    private

    def find_verified_user
      TokenVerifier.call(request.params[:token])
    end
  end
end
