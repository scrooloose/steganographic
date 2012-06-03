Website::Application.routes.draw do
  devise_for :users

  resource :dashboard, :controller => 'dashboard', :only => :show

  resources :images, :only => [:new, :create]
  resources :challenges, :only => [:new, :create] do
    resources :responses, :only => [:new, :create]
  end

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => "home#index"
end
