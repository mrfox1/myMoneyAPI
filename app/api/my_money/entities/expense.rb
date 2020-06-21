module MyMoney
  module Entities
    class Expense < Grape::Entity
      expose :id
      expose :sum
      expose :date
      expose :description
      expose :created_at
    end
  end
end
