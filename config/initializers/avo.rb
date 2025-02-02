Avo.configure do |config|
  config.root_path = '/avo'
  config.current_user_method = :current_user
  config.authenticate_with do
    redirect_to main_app.new_user_session_path unless current_user&.admin?
  end
end
