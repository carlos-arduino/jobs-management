Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  devise_for :candidates , controllers: {
    registrations: 'candidates/registrations',
    sessions: 'candidates/sessions',
    passwords: 'candidates/passwords'
  }
  
  get '/jobs', to: 'jobs#index'
  get 'search', to: 'jobs#search'
  
  resources :companies, only: [:new, :create, :show, :index] do
    resources :jobs , only: [:new, :create, :show, :edit, :update] do
      post 'disable', on: :member
      post 'enroll', on: :member
      resources :enrollments, only: [:show, :edit, :update]
    end
  end

  resources :enrollments, only: [:index]
end
