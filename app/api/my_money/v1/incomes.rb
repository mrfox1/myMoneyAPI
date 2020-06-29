module MyMoney
  module V1
    class Incomes < Grape::API
      rescue_from ActiveRecord::RecordInvalid do |error|
        message = error.record.errors.messages.map { |attr, msg| "#{attr.to_s} #{msg.join(", ")}" }
        error!(message, 400)
      end

      before { auth_with_token! }

      resource :incomes do
        desc "Return list of incomes"
        get do
          incomes = current_user.incomes.includes(:category)
          present incomes, with: MyMoney::Entities::Income
        end

        desc "Return a specific profit"
        route_param :id do
          get do
            income = current_user.incomes.find_by(id: params[:id])
            return error!("Record was not found", 404) if income.nil?
            present income, with: MyMoney::Entities::Income
          end
        end

        desc "Create an income"
        params do
          requires :income, type: Hash do
            requires :sum, type: Float
            requires :date, type: Date
            optional :description, type: String
            requires :category_id, type: Integer
          end
        end
        post do
          check_category!(params[:income][:category_id], "Income")
          income = current_user.incomes.create!(params[:income])
          present income, with: MyMoney::Entities::Income
        end

        desc "Update the income"
        params do
          requires :income, type: Hash do
            optional :sum, type: Float
            optional :date, type: Date
            optional :description, type: String
            optional :category_id, type: Integer
          end
        end
        route_param :id do
          put do
            check_category!(params[:income][:category_id], "Income")
            income = current_user.incomes.find_by(id: params[:id])
            return error!("Record was not found", 404) if income.nil?
            income.update!(params[:expense])
            present income, with: MyMoney::Entities::Income
          end
        end

        desc "Delete the income"
        route_param :id do
          delete do
            income = current_user.incomes.find_by(id: params[:id])
            return error!("Record was not found", 404) if income.nil?
            income.destroy!
            error!(:no_content, 204)
          end
        end
      end
    end
  end
end
