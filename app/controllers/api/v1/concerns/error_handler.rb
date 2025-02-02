module Api
  module V1
    module Concerns
      module ErrorHandler
        extend ActiveSupport::Concern

        included do
          rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
          rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
          rescue_from AuthenticationErrors::InvalidTokenError, with: :render_unauthorized
          rescue_from AuthenticationErrors::ExpiredTokenError, with: :render_unauthorized
          rescue_from AuthenticationErrors::AuthenticationError, with: :render_unauthorized
        end

        private

        def render_unprocessable_entity(exception)
          render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
        end

        def render_not_found(exception)
          render json: { errors: [exception.message] }, status: :not_found
        end

        def render_unauthorized(exception)
          render json: { errors: [exception.message] }, status: :unauthorized
        end
      end
    end
  end
end
