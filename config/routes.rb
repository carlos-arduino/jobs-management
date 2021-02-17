Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :companies, only: [:new, :create, :show, :index] do
    resources :jobs , only: [:index, :new, :create, :show, :edit, :update] do
      post 'disable', on: :member
    end
  end
  
end
