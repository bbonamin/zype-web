# frozen_string_literal: true
Rails.application.routes.draw do
  resources :videos, only: [:index]
end
