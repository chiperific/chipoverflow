# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'application#homepage', as: :homepage

  resources :posts, except: %i[show index] do
    resources :comments do
      member do
        get 'vote'
        get 'flag'
      end
    end

    member do
      get 'vote'
      get 'bookmark'
    end
  end

  ## =====> Hello, Interviewers!
  #
  # Just mimicking what StackOverflow does for urls
  # It's probably for SEO
  get '/questions/:id(/:title_slug)', to: 'posts#show', as: 'show_post'

  get '/search', to: 'posts#search', as: 'search_posts'

  get '/search/:tag_name', to: 'tags#search', as: 'search_tags'
end
