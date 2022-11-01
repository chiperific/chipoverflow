# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'application#homepage', as: :homepage

  resources :posts, except: %i[show index] do
    resources :comments
  end

  ## =====> Hello, Interviewers!
  # just mimicking what StackOverflow does for urls
  # maybe it's for SEO?
  get '/questions/:id(/:title_slug)', to: 'posts#show', as: 'show_post'

  get '/search', to: 'posts#search', as: 'search_posts'
end
