# frozen_string_literal: true
Rails.application.routes.draw do
  resources :videos, only: [:index, :show]
  resources :sessions, only: [:new, :create]

  root to: 'videos#index'
end
