Rails.application.routes.draw do
  resources :records

  get 'records', to: 'records#index'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

  root 'pages#home'
end
