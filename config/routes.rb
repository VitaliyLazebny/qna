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
    resources :answers, only: [] do
      resources :votes, only: :create
      delete :vote
    end
  end

  resources :attachments, only: :destroy
  resources :awards, only: :index
end
