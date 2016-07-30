Rails.application.routes.draw do
  
  #devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :articles
  root to: 'pages#index'

  get 'pages/about'
  get 'pages/contact'

end
