Rails.application.routes.draw do
  # root
  root 'public#index'

  # admin
  get  '/admin', to: 'admin#index'
  get '/admin/logout', to: 'admin#logout'

  # forces the controllers to use the admin name space
  # this is going to allow for the addition of a function to restrict access
  # resources generates all routes for crud of libraries, departments, users, etc.

  scope '/admin' do
    resources :users, :email_addresses, module: 'admin'
    get '/email_addresses/new/:user_id', to: 'admin/email_addresses#new',  as: 'new_email_address_2'
  end

  get '/directory', to: 'directory#index'
end
