Rails.application.routes.draw do
  # root
  root 'public#index'

  # admin
  get '/admin', to: 'admin#index'

  get '/login', to: 'public#login'
  get '/logout', to: 'public#logout'

  # forces the controllers to use the admin name space
  # this is going to allow for the addition of a function to restrict access
  # resources generates all routes for crud of libraries, departments, users, etc.

  scope '/admin' do
    resources :users, module: 'admin'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
