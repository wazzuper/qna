Rails.application.routes.draw do
  devise_for :users

  concern :votable do
    member do
      patch :vote_up
      patch :vote_down
    end
  end

  resources :answers
  resources :questions, concerns: :votable do
    resources :answers, only: [:create, :update], shallow: true, concerns: :votable do
      patch 'set_best', on: :member
    end
  end
  resources :attachments, only: [:destroy]

  root to: 'questions#index'
end
