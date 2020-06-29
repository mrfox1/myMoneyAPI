module MyMoney
  class Base < Grape::API
    prefix :api
    version 'v1', using: :path
    format :json
    helpers Helpers::Authenticate, Helpers::Permissions

    mount MyMoney::V1::Categories
    mount MyMoney::V1::Expenses
    mount MyMoney::V1::Incomes
    mount MyMoney::V1::Users
  end
end
