class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Api::V1::Concerns::ErrorHandler
end
