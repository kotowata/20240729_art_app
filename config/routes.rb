Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "static_pages#top"
  get "terms", to: "static_pages#terms"
  get "privacy_policy", to: "static_pages#privacy_policy"
  get "maps", to: "maps#show", as: "map"

  resources :users, only: %i[new create]
  resources :posts, only: %i[index new create show edit update destroy] do
    collection do
      get :likes
      get :my_posts
    end
  end
  resources :likes, only: %i[create destroy]
  resource :mypage, only: %i[show edit update]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  resources :password_resets, only: %i[new create edit update]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
