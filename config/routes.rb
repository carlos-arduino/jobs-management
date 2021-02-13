Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  resources :jobs , only: [:index] #Provavelmente no futuro esse resource sera aninhado com companies
  resources :companies, only: [:new, :create, :show]
end
