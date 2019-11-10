module Api
  module V1
    class CategoriesController < ApiController
      before_action :set_category, except: :index

      def index
        categories = current_user.categories.order(:name)
        render json: categories
      end

      def show
        @records = @category.record_type == "Expense" ? @category.expenses : @category.incomes
        render json: @category
      end

      def create
        category = Category.new(category_params)
        category.user = current_user
        if category.save
          render json: category, status: :created
        else
          render_error(category.errors.full_messages.join(", "), :unprocessable_entity)
        end
      end

      def update
        if @category.update(category_params)
          render json: @category
        else
          render_error(@category.errors.full_messages.join(", "), :unprocessable_entity)
        end
      end

      def destroy
        @income.destroy
        head :no_content
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name, :record_type)
      end
    end
  end
end
