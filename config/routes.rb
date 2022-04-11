Rails.application.routes.draw do
  resources :interventions
  post 'twilio/sms'
  resources :quotes
  get 'quotes/quote'
  get 'errors/not_found'
  get 'errors/internal_server_error'

  root "home#index"
 
  get 'dropbox/auth' => 'dropbox#auth'
  get 'dropbox/setup' => 'dropbox#setup'
  get 'dropbox/auth_callback' => 'dropbox#auth_callback'

  resources :leads, :path =>'leads'
  post '/leads', to: 'leads#create'


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
  get 'rails_admin/data/playbriefing', to: 'data#playbriefing'
  get 'rails_admin/data/map', to: 'data#map'


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
  
# config/routes.rb

# Rails.application.routes.draw do
  resources :interventions, :except => [:destroy, :edit, :update, :show]
  
  get 'interventions/get_buildings/:customer_id', to: 'interventions#get_buildings'
  get 'interventions/get_batteries/:building_id', to: 'interventions#get_batteries'
  get 'interventions/get_columns/:battery_id', to: 'interventions#get_columns'
  get 'interventions/get_elevators/:column_id', to: 'interventions#get_elevators'

#  end



  match "404", to: "errors#not_found", via: :all
  match "500", to: "errors#internal_server_error", via: :all




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
