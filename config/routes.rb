Rails.application.routes.draw do
  resources :events do
    resources :attendances, only: [:new, :create]
    resources :pictures, only: [:create]
  end
  root "events#index"
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    resources :avatars, only: [:create]
  end
  post 'checkout', to: 'checkout#create'
  resources :attendances do
    collection do
      get :success
    end
  end

  
 

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
