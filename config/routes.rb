Rails.application.routes.draw do
  # get 'tasks/index'

  devise_for :users
  # get 'home/index'

  root 'home#index'

  resources :tasks
  resources :home

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
