class AdminChannel < ApplicationCable::Channel
  def subscribed
    if current_user.is_a?(Admin)
      stream_from "admin_channel"
    else
      reject_unauthorized_connection
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
