module Users
  class SessionsController < Devise::SessionsController
    def after_sign_in_path_for(resource)
      if resource.type == 'Admin'
        avo_root_path
      else
        root_path
      end
    end

    def after_sign_out_path_for(_resource)
      new_user_session_path
    end
  end
end
