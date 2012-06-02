Website::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

end
