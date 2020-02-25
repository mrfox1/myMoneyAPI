module Api
  module V1
    class ExpensesController < ApiController
      before_action :set_expense, only: [:update, :destroy]

      def index
        @expenses = current_user.expenses.includes(:category)
      end

      def create
        @expense = Expense.new(expense_params)
        @expense.user = current_user
        if @expense.save
          render json: @expense, status: :created
        else
          render_error(@expense.errors.full_messages[0], :unprocessable_entity)
        end
      end

      def update
        if @expense.update(expense_params)
          @expense
        else
          render_error(@expense.errors.full_messages[0], :unprocessable_entity)
        end
      end

      def destroy
        @expense.destroy
        head :no_content
      end

      private

      def set_expense
        @expense = Expense.find(params[:id])
      end

      def expense_params
        params.require(:expense).permit(:sum, :date, :description, :category_id)
      end
    end
  end
end
