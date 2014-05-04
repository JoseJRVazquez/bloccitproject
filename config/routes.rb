#This calls the Resources method, passes the symbol to it, and instructs rails to create routes for each CRUD action
Bloccit::Application.routes.draw do



  get "posts/index"
  devise_for :users
  resources :users, only: [:show, :index, :update]

  resources :posts, only: [:index]
  
  resources :topics do
    resources :posts, except: [:index], controller: 'topics/postss' do
      resources :comments, only: [:create, :destroy]


      #vote routes for up or down votes
      get '/up-vote' => 'votes#up_vote', as: :up_vote
      get '/down-vote' => 'votes#down_vote', as: :down_vote

      resources :favorites, only: [:create, :destroy]
    end
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
