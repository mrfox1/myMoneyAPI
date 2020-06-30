module MyMoney
  module V1
    class Expenses < Grape::API

      rescue_from ActiveRecord::RecordInvalid do |error|
        message = error.record.errors.messages.map { |attr, msg| "#{attr.to_s} #{msg.join(", ")}" }
        error!(message, 400)
      end

      before { auth_with_token! }

      resource :expenses do
        desc "Return list of expenses"
        get do
          expenses = current_user.expenses.includes(:category)
          present expenses, with: MyMoney::Entities::Expense
        end

        desc "Return a specific expense"
        route_param :id do
          get do
            expense = current_user.expenses.find_by(id: params[:id])
            return error!("Record was not found", 404) if expense.nil?
            present expense, with: MyMoney::Entities::Expense
          end
        end

        desc "Create an expense"
        params do
          requires :expense, type: Hash do
            requires :sum, type: Float
            requires :date, type: Date
            optional :description, type: String
            requires :category_id, type: Integer
          end
        end
        post do
          check_category!(params[:expense][:category_id], "Expense")
          expense = current_user.expenses.create!(params[:expense])
          present expense, with: MyMoney::Entities::Expense
        end

        desc "Update the expense"
        params do
          requires :expense, type: Hash do
            optional :sum, type: Float
            optional :date, type: Date
            optional :description, type: String
            optional :category_id, type: Integer
          end
        end
        route_param :id do
          put do
            check_category!(params[:expense][:category_id], "Expense")
            expense = current_user.expenses.find_by(id: params[:id])
            return error!("Record was not found", 404) if expense.nil?
            expense.update!(params[:expense])
            present expense, with: MyMoney::Entities::Expense
          end
        end

        desc "Delete the expense"
        route_param :id do
          delete do
            expense = current_user.expenses.find_by(id: params[:id])
            return error!("Record was not found", 404) if expense.nil?
            expense.destroy!
            error!(:no_content, 204)
          end
        end
      end
    end
  end
end
