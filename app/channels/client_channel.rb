class ClientChannel < ApplicationCable::Channel
  def subscribed
    if current_user.is_a?(Client)
      stream_from "client_channel"
    else
      reject_unauthorized_connection
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
