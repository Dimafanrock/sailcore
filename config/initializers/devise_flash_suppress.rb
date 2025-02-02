# Define the module outside the block
module DeviseFlashSuppress
  def set_flash_message!(_key, _kind, _options = {})
    # Prevents flash messages in API mode
  end
end

ActiveSupport.on_load(:devise_controller) do
  require "devise" # Ensure Devise is loaded
  Devise::SessionsController.prepend DeviseFlashSuppress
end
