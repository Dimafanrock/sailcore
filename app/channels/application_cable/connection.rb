module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    rescue StandardError
      reject_unauthorized_connection
    end

    private

    def find_verified_user
      token = request.params[:token]
      return nil if token.blank?

      decoded_token = begin
        JsonWebToken.decode(token)
      rescue StandardError
        nil
      end
      return nil if decoded_token.blank?

      user = User.find_by(id: decoded_token[:user_id])
      user || reject_unauthorized_connection
    end
  end
end
