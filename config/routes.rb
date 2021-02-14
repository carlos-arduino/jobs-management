Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :jobs , only: [:index, :new, :create, :show] #Provavelmente no futuro esse resource sera aninhado com companies
  resources :companies, only: [:new, :create, :show, :index]
end
