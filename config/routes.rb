Rails.application.routes.draw do
  root to: 'engineers#index'

  resources :engineers, only: [ :create ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
