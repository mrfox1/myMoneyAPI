module MyMoney
  module Entities
    module Categories
      class CategoryWithNestedTable < Grape::Entity
        expose :id
        expose :name
        expose :record_type

        expose :expenses, as: :records, using: Expense
        expose :incomes, as: :records
      end
    end
  end
end