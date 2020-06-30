module MyMoney
  module Entities
    module Categories
      class Category < Grape::Entity
        expose :id
        expose :name
        expose :record_type
      end
    end
  end
end