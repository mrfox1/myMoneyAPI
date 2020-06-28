Rails.application.routes.draw do
  mount MyMoney::Base, at: "/"

  # TODO: add the following routes
  # namespace :api, defaults: { format: :json} do
  #   namespace :v1 do
  #     resources :incomes, except: [:show, :new, :edit]
  #   end
  # end
end
