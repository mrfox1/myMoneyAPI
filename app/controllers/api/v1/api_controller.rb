module Api
  module V1
    class ApiController < ApplicationController
      before_action :auth_with_token!

      def render_error(message, status)
        status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
        render json: { error: { status: status_code, message: message } },
               status: status
      end

      def current_user
        user = User.find_by_token(request.headers['Authorization'])
        @current_user ||= user if user.present?
      end

      def user_signed_in?
        current_user.present?
      end

      def auth_with_token!
        render_error('Invalid token!', :unauthorized) unless user_signed_in?
      end
    end
  end
end
