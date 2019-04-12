module Api
  module V1
    class ApiController < ApplicationController

      def render_error(message, status)
        status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
        render json: { error: { status: status_code, message: message } },
               status: status
      end
    end
  end
end
