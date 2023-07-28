# Rails routes: https://railsguides.jp/routing.html
# resources v.s get/post/put/delete... : Use resources for full CRUD routes such as users, articles, comments, etc. Use get for simpler pages with only one or two actions like home or about pages.
Rails.application.routes.draw do
  resources :records do
    member do
      post 'add_images'
    end
  end
  
  resources :users, only: [:index,:show]
  resources :machines, only: [:index,:show]

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  root 'pages#home'


  get 'aws', to: 'aws#index'


  
end
