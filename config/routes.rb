Rails.application.routes.draw do
  devise_for :users
  resources :answers
  resources :questions do
    resources :answers, only: [:create, :update] do
      patch 'set_best', on: :member
    end
  end

  root to: 'questions#index'
end
