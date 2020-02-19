Rails.application.routes.draw do
  root to: 'landing#index'
  resources :data
end
