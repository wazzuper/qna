Rails.application.routes.draw do
  devise_for :users
  resources :answers
  resources :questions do
    resources :answers, only: [:create, :update], shallow: true do
      patch 'set_best', on: :member
    end
  end
  resources :attachments, only: [:destroy]

  root to: 'questions#index'
end
