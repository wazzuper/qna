Rails.application.routes.draw do
  devise_for :users
  resources :answers
  resources :questions do
    resources :answers, only: [:create]
  end

  root to: 'questions#index'
end
