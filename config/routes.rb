# Rails.application.routes.draw do
#   # home index
#   root to: 'application#home'
#   get '/home', to: 'application#home', as: 'home'
#
#   # auth
#   get '/login', to: 'application#login', as: 'login'
#   get '/logout', to: 'application#logout', as: 'logout'
#
#   # public
#   get '/directory', to: 'directory#list', as: 'directory_list'
#   get '/directory/show/:user_id', to: 'directory#show', as: 'show_user_profile'
#
#   # admin
#   get '/admin', to: 'admin#home', as: 'admin_home'
#
#   get '/directory', to: 'directory#index'
#   resources :directory, only: [:index, :show]
#
#   # admin namespaces for crud tasks
#   namespace :admin do
#     resources :users, :optional_items, :email_addresses, :universities
#   end
# end


Rails.application.routes.draw do
  # home index
  root to: 'application#home'
  get '/home', to: 'application#home', as: 'home'

  # auth
  get '/login', to: 'application#login', as: 'login'
  get '/logout', to: 'application#logout', as: 'logout'

  # root
  # root 'public#index'
  # resources :registration, only: [:new, :create], module: 'public'

  # admin
  get '/admin', to: 'admin#index'
  # get '/admin/logout', to: 'admin#logout'

  # forces the controllers to use the admin name space
  # this is going to allow for the addition of a function to restrict access
  # resources generates all routes for crud of libraries, departments, users, etc.

  scope '/admin' do
    resources :users, :optional_items, :email_addresses, :universities, module: 'admin'
    get '/email_addresses/new/:user_id', to: 'admin/email_addresses#new',  as: 'new_email_address_2'
    get '/optional_items/edit/:user_id', to: 'admin/optional_items#edit', as: 'edit_optional_items'
  end

  get '/directory', to: 'directory#index'
  resources :directory, only: %i[index show]

  get '/directory/show/:user_id', to: 'directory#show', as: 'show_user_profile'

  # admin namespaces for crud tasks
  namespace :admin do
    resources :users, :optional_items, :email_addresses, :universities
  end
end
