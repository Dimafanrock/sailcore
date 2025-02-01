Avo.configure do |config|
  config.root_path = '/admin'
  config.current_user_method = :current_user
  config.authenticate_with do
    redirect_to new_user_session_path unless current_user.is_a?(Admin)
  end
end
