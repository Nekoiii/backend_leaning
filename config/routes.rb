Rails.application.routes.draw do
  resources :records
  resources :users, only: [:show]
  resources :machines, only: [:show]

  get 'records', to: 'records#index'
  get 'users', to: 'users#index'
  get 'machines', to: 'machines#index'

  get 'aws', to: 'aws#index'
  
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

  root 'pages#home'
end
