Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/chat", to:'chats#list'
      get "/chat/:id", to: 'chats#show'
      post "/chat", to: 'chats#new'
      delete "/chat/:id", to: 'chats#destroy'
      put "/chat/:id", to: 'chats#edit'
      get "/application", to:'applications#list'
      get "/application/:id", to: 'applications#show'
      put "/application/:id", to: 'applications#edit'
      post "/application", to: 'applications#new'
      delete "/application/:id", to: 'applications#destroy'
      get "/message", to:'messages#list'
      get "/message/:id", to: 'messages#show'
      post "/message", to: 'messages#new'
      delete "/message/:id", to: 'messages#destroy'
      put "/message/:id", to: 'messages#edit'
    end
  end
end
