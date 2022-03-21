Rails.application.routes.draw do
  resources :quotes
  get 'quotes/quote'
  get 'errors/not_found'
  get 'errors/internal_server_error'

  root "home#index"
 

  resources :leads, :path =>'leads'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # namespace :admin do
  #   controller :admin do
  #     get 'data/index', to: 'data#index'
  #     # get '/', action: :index
  #     # get :login
  #     # get :logout
  #   end
  #   # resources :events
  # end
  get 'rails_admin/data/index', to: 'data#index'
  get 'admin/rails_admin/data/index', to: 'data#index'

  # get '/', to: "home#index"
  get "residential", to: "home#residential"
  get "commercial", to: "home#commercial"
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  resources :quotes do 
    member do
      get 'preview'
    end
  end
  
  match "404", to: "errors#not_found", via: :all
  match "500", to: "errors#internal_server_error", via: :all

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
