# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'application#homepage', as: :homepage

  get '/reputation', to: 'chips#reputation', as: :reputation
end
