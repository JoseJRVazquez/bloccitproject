#This calls the Resources method, passes the symbol to it, and instructs rails to create routes for each CRUD action
Bloccit::Application.routes.draw do



  devise_for :users
  resources :users, only: [:update]

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
    end
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
