module MyMoney
  module V1
    class Categories < Grape::API

      rescue_from ActiveRecord::RecordInvalid do |error|
        message = error.record.errors.messages.map { |attr, msg| "#{attr.to_s} #{msg.join(", ")}" }
        error!(message, 400)
      end

      before { auth_with_token! }

      resource :categories do
        desc "Return a list of categories or sorted list by category type"
        params do
          optional :record_type, type: String, values: %w(Expense Income)
        end
        get do
          categories = current_user.categories
          categories = categories.by_type(params[:record_type]) if params[:record_type].present?
          present categories, with: MyMoney::Entities::Categories::Category
        end

        desc "Return specific category and her records"
        route_param :id do
          get do
            category = current_user.categories.find_by(id: params[:id])
            return error!("Record was not found", 404) if category.nil?
            present category, with: MyMoney::Entities::Categories::CategoryWithNestedTable
          end
        end

        desc "Create category"
        params do
          requires :category, type: Hash do
            requires :name, type: String
            requires :record_type, type: String, values: %w(Expense Income)
          end
        end
        post do
          category = current_user.categories.create!(params[:category])
          present category, with: MyMoney::Entities::Categories::Category
        end

        #TODO: 1. Delete nested records if change record_type
        desc "Update the category"
        params do
          requires :category, type: Hash do
            optional :name, type: String
            optional :record_type, type: String, values: %w(Expense Income)
          end
        end
        route_param :id do
          put do
            category = current_user.categories.find_by(id: params[:id])
            return error!("Record was not found", 404) if category.nil?
            category.update(params[:category])
            present category, with: MyMoney::Entities::Categories::Category
          end
        end

        desc "Delete the category"
        route_param :id do
          delete do
            category = current_user.categories.find_by(id: params[:id])
            return error!("Record was not found", 404) if category.nil?
            category.destroy!
            error!(:no_content, 204)
          end
        end
      end
    end
  end
end