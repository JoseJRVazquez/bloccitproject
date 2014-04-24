#This calls the Resources method, passes the symbol to it, and instructs rails to create routes for each CRUD action
Bloccit::Application.routes.draw do

  resources :posts

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
