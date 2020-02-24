module Api
  module V1
    class IncomesController < ApiController
      before_action :set_income, only: [:update, :destroy]

      def index
        @incomes = current_user.incomes.includes(:category)
      end

      def create
        income = Income.new(income_params)
        income.user = current_user
        if income.save
          render json: income, status: :created
        else
          render_error(income.errors.full_messages[0], :unprocessable_entity)
        end
      end

      def update
        if @income.update(income_params)
          render json: @income
        else
          render_error(@income.errors.full_messages[0], :unprocessable_entity)
        end
      end

      def destroy
        @income.destroy
        head :no_content
      end

      private

      def income_params
        params.require(:income).permit(:sum, :date, :description, :category_id)
      end

      def set_income
        @income = Income.find(params[:id])
      end
    end
  end
end
