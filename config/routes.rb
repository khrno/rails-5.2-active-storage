Rails.application.routes.draw do
  namespace :admin do
    root 'dashboard#index'
    resources :categories, only: :index
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
