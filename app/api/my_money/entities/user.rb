module MyMoney
  module Entities
    class User < Grape::Entity
      expose :name
      expose :email
      expose :token
    end
  end
end