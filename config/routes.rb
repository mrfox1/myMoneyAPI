Rails.application.routes.draw do
  namespace :api, defaults: { format: :json} do
    namespace :v1 do
      resources :categories, except: [:new, :edit]
      resources :incomes, except: [:show, :new, :edit]
      resources :expenses, except: [:show, :new, :edit]
      resources :users, only: [:create, :update]
      post 'users/login'
      get 'users/logout'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
