Website::Application.routes.draw do
  devise_for :users

  resource :leaderboard, :controller => 'leaderboard', :only => :show

  resources :images, :only => [:new, :create]
  resources :challenges, :only => [:new, :create, :show] do
    resources :responses, :only => [:new, :create, :show]
  end

  resources :challenge_emails, :only => [:create]

  resources :vowel_purchases, :only => [:new]

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  match "home/signup" => "home#signup_login", :as => :signup_login, :via => :post

  root :to => "home#index"
end
