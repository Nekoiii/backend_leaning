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
