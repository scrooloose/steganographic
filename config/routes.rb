Website::Application.routes.draw do
  devise_for :users

  resources :images
  resources :challenges

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
end
