module MyMoney
  module Entities
    class Income < Grape::Entity
      expose :id
      expose :sum
      expose :date
      expose :description
      expose :created_at
    end
  end
end
