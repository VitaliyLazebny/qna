# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, shallow: true do
      patch :make_best, on: :member
    end
  end

  namespace :api, defaults: { format: :json } do
    resources :votes, only: :create
    delete :votes, controller: :votes, action: :destroy
  end

  resources :attachments, only: :destroy
  resources :awards, only: :index

  mount ActionCable.server => '/cable'
end
