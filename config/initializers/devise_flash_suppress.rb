ActiveSupport.on_load(:devise_controller) do
  require "devise" # Ensure Devise is loaded

  module DeviseFlashSuppress
    def set_flash_message!(_key, _kind, _options = {})
      # Prevents flash messages in API mode
    end
  end

  Devise::SessionsController.prepend DeviseFlashSuppress
end
