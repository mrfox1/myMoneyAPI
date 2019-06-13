module Api
  module V1
    class UsersController < ApiController
      def create
        @user = User.new(user_params)
        @user.email.downcase
        if @user.save
          render status: :created
        else
          render_error(@user.errors.full_messages[0], :unprocessable_entity)
        end
      end

      def update
        user = User.find(params[:id])
        if user.id != current_user.id
          head :not_found
        elsif user.update(user_params)
          render json: user
        else
          render_error(user.errors.full_messages[0], :unprocessable_entity)
        end
      end

      def login
        @user = User.find_by_email(params[:user][:email].downcase)
        if @user && @user.authenticate(params[:user][:password])
          @user.regenerate_token
          @user
        else
          head :not_found
        end
      end

      def logout
        current_user.regenerate_token
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end