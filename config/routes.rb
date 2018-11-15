Rails.application.routes.draw do
  # home index
  root to: 'application#home'
  get '/home', 
      to: 'application#home', 
      as: 'home'

  # auth
  get '/login', 
      to: 'application#login', 
      as: 'login'
      
  get '/logout', 
      to: 'application#logout', 
      as: 'logout'

  # admin
  get '/admin', to: 'admin#index'

  # forces the controllers to use the admin name space
  # this is going to allow for the addition of a function to restrict access
  # resources generates all routes for crud of libraries, departments, users, etc.

  scope '/admin' do
    resources :colleges, :users, :faculties, module: 'admin'
  end

  get '/directory', to: 'directory#index'
  #resources :directory, only: %i[index show]
  
  get 'directory',
      to: 'directory#list',
      as: 'directory_list'

  get '/directory/:id', 
      to: 'directory#show', 
      as: 'directory_show'
      
  # search
  get '/search',
      to: 'search#index',
      as: 'search_index'

  # admin namespaces for crud tasks
  namespace :admin do
    resources :colleges,
              :users,
              :faculties
  end
end
