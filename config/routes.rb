Rails.application.routes.draw do
  resources :chats
  resources :chat_room_members
  resources :chat_rooms do
    resources :chats
  end
  resources :users 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
