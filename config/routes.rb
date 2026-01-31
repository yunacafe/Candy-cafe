Rails.application.routes.draw do

devise_for :users



root "tweets#index"

resources :users, only: [:show] 

resources :tweets do 
   resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]

 end
end
