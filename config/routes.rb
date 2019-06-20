Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/chat", to:'chat#list'
      get "/chat/:id", to: 'chat#show'
      post "/chat", to: 'chat#new'
      delete "/chat/:id", to: 'chat#destroy'
      put "/chat/:id", to: 'chat#edit'
      get "/application", to:'application#list'
      get "/application/:id", to: 'application#show'
      post "/application", to: 'application#new'
      delete "/application/:id", to: 'application#destroy'
      put "/application/:id", to: 'application#edit'
      get "/message", to:'message#list'
      get "/message/:id", to: 'message#show'
      post "/message", to: 'message#new'
      delete "/message/:id", to: 'message#destroy'
      put "/message/:id", to: 'message#edit'
    end
  end
end
