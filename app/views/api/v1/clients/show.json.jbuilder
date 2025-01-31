json.user do
  json.extract! @current_api_v1_user, :id, :email, :name, :nickname, :image, :type
  json.token @token
end
