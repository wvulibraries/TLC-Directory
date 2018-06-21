Rails.application.routes.draw do
  # root
  root 'public#index'
  resources :registration, only: [:new, :create], module: 'public'

  # admin
  get  '/admin', to: 'admin#index'
  get '/admin/logout', to: 'admin#logout'

  # forces the controllers to use the admin name space
  # this is going to allow for the addition of a function to restrict access
  # resources generates all routes for crud of libraries, departments, users, etc.

  scope '/admin' do
    resources :users, :optional_items, :email_addresses, module: 'admin'
    get '/email_addresses/new/:user_id', to: 'admin/email_addresses#new',  as: 'new_email_address_2'
    get '/optional_items/edit/:user_id', to: 'admin/optional_items#edit', as: 'edit_optional_items'
  end

  get '/directory', to: 'directory#index'
  get '/directory/show/:user_id', to: 'directory#show', as: 'show_user_profile'
end
