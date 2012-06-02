Website::Application.routes.draw do
  resources :images

  resources :challenges

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

end
