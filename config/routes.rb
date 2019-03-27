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

  get '/admin/faculties/importzip', 
      to: 'admin/faculties#importzip', 
      as: 'admin/faculties_import_zip'
      
  get '/admin/faculties/importcsv', 
      to: 'admin/faculties#importcsv', 
      as: 'admin/faculties_import_csv'

  # forces the controllers to use the admin name space
  # this is going to allow for the addition of a function to restrict access
  # resources generates all routes for crud of libraries, departments, users, etc.

  scope '/admin' do
    resources :colleges, :departments, :faculties, :users, :searchstats, module: 'admin'
  end

  # admin namespaces for crud tasks
  namespace :admin do
    resources :colleges,
              :departments,
              :users
    resources :faculties do
        collection { post :importzip, :importcsv }
    end
  end

  get '/directory', to: 'directory#index'

  get 'directory',
      to: 'directory#list',
      as: 'directory_list'

  get '/directory/faculties/:id', 
      to: 'directory#show', 
      as: 'directory_show'

  # colleges
  get '/directory/colleges',
      to: 'directory/colleges#list',
      as: 'directory/colleges_list'

  get '/directory/colleges/:id/faculties',
      to: 'directory/colleges#faculties',
      as: 'directory/colleges_faculties'

  get '/directory/colleges/:id',
      to: 'directory/colleges#details',
      as: 'directory/college_details'

  # departments
  get '/directory/departments',
      to: 'directory/departments#list',
      as: 'directory/departments_list'

  get '/directory/departments/:id',
      to: 'directory/departments#details',
      as: 'directory/department_details'

  get '/directory/departments/:id/faculties',
      to: 'directory/departments#faculties',
      as: 'directory/departments_faculties'
end
