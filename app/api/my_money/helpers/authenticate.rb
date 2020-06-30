module MyMoney
  module Helpers
    module Authenticate
      extend Grape::API::Helpers

      def current_user
        @current_user ||= User.try(:find_by, token: request.headers['Authorization'])
      end

      def user_signed_in?
        current_user.present?
      end

      def auth_with_token!
        error!('Unauthorized. Invalid or expired token.', 401) unless user_signed_in?
      end
    end
  end
end
