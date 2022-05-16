Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations' }
  resources :tweets

  
  resources :likes, only: [:create, :destroy]

  #resources :users, only: [:index, :show, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tweets#index"

  resource :friendships, only: [:create, :destroy]


  get '/tweets/likes/:id', to: "tweets#likes"
  get 'search', to: "tweets#search"
  get '/tweets/hashtag/:name', to: "tweets#hashtags"
  get 'profile' => "friendships#profile"
  get 'followers_list' => "friendships#followers_list"
  get 'followings_list' => "friendships#followings_list"

end
