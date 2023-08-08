# frozen_string_literal: true

# Rails routes: https://railsguides.jp/routing.html
# resources v.s get/post/put/delete... : Use resources for full CRUD routes such as users, articles, comments, etc. Use get for simpler pages with only one or two actions like home or about pages.
Rails.application.routes.draw do
  resources :records do
    member do
      post 'add_images'
    end
  end

  resources :users, only: %i[index show]
  resources :machines, only: %i[index show]

  root 'pages#home'
  get  '/signup', to: 'users#new'

  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'

  get 'aws', to: 'aws#index'
end
