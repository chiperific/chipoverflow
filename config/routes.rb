# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'application#homepage', as: :homepage

  get '/signin', to: 'application#sign_in', as: :sign_in

  get '/showphone', to: 'application#show_phone', as: :show_phone

  post '/contact', to: 'application#contact', as: :contact

  resources :posts, only: [] do
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

  resources :tags, only: %i[index show] do
    collection do
      post :live_search
    end
  end

  ## =====> Hello, Interviewers!
  #
  # Just mimicking what StackOverflow does for urls
  # It's probably for SEO
  get '/questions/:id(/:title_slug)', to: 'posts#show', as: 'show_post'

  get '/search', to: 'posts#search', as: 'search_posts'

  get '/search/:tag_name', to: 'tags#search', as: 'search_tags'

  # catch-all route
  # https://github.com/rails/rails/issues/31228
  get '*path',
      to: 'application#sign_in',
      constraints: lambda { |req|
        req.path.exclude? 'rails/active_storage'
      }
end
