Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/chats", to:'chat#list'
      get "/chats/:id", to: 'chat#show'
      post "/chats", to: 'chat#new'
      delete "/chats/:id", to: 'chat#destroy'
      put "/chats/:id", to: 'chat#edit'
      get "/applications", to:'application#list'
      get "/applications/:id", to: 'application#show'
      post "/applications", to: 'application#new'
      delete "/applications/:id", to: 'application#destroy'
      put "/applications/:id", to: 'application#edit'
      get "/messages", to:'message#list'
      get "/messages/:id", to: 'message#show'
      post "/messages", to: 'message#new'
      delete "/messages/:id", to: 'message#destroy'
      put "/messages/:id", to: 'message#edit'
    end
  end
end
