Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_for :candidates , controllers: {
    registrations: 'candidates/registrations',
    sessions: 'candidates/sessions'
  }
  
  get 'company_page', to: 'companies#index'
  get 'search', to: 'jobs#search'
  
  resources :jobs, only: [:index, :show, :edit, :update] do
    post 'disable', on: :member
    post 'enroll', on: :member
  end

  resources :enrollments, only: [:index, :show] do
    get 'decline', on: :member
    patch 'declined', on: :member
    resources :proposals, only: [:new, :create]
  end
  
  resources :companies, only: [:edit, :update] do
    resources :jobs , only: [:new, :create]
  end
    
  resources :proposals, only: [:show] do
    patch 'accept', on: :member
    get 'decline', on: :member
    patch 'declined', on: :member
  end
end
