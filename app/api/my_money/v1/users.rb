module MyMoney
  module V1
    class Users < Grape::API

      rescue_from ActiveRecord::RecordInvalid do |error|
        message = error.record.errors.messages.map { |attr, msg| "#{attr.to_s} #{msg.join(", ")}" }
        error!(message, 400)
      end

      resources :users do
        desc "Create user"
        params do
          requires :user, type: Hash do
            requires :name, type: String
            requires :email, type: String
            requires :password, type: String
          end
        end
        post do
          user = User.create!(params[:user])
          present user, with: MyMoney::Entities::User
        end

        desc "sign in user"
        params do
          requires :user, type: Hash do
            requires :email, type: String
            requires :password, type: String
          end
        end
        post "/login" do
          user = User.find_by_email(params[:user][:email].downcase)
          if user && user.authenticate(params[:user][:password])
            user.regenerate_token
            present user, with: MyMoney::Entities::User
          else
            error!("Wrong email or password", 401)
          end
        end

        delete "/logout" do
          auth_with_token!
          current_user.regenerate_token
          error!(:no_content, 204)
        end

        desc "Update users data"
        params do
          requires :token, type: String
          requires :user, type: Hash do
            optional :name, type: String
            optional :email, type: String
            optional :password, type: String
          end
        end
        put ":token" do
          user = User.find_by(token: params[:token])
          if user.update(params[:user])
            present user, with: MyMoney::Entities::User
          else
            error!('Unauthorized. Invalid or expired token.', 401)
          end
        end
      end
    end
  end
end