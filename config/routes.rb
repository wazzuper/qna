Rails.application.routes.draw do
  devise_for :users
  resources :answers
  resources :questions do
    resources :answers, only: [:create, :update]
  end

  root to: 'questions#index'
end
