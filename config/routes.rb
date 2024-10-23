Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root "static_pages#top"

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
  # Google認証
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  get "terms", to: "static_pages#terms"
  get "privacy_policy", to: "static_pages#privacy_policy"
  get "maps", to: "maps#show", as: "map"

  # get "up" => "rails/health#show", as: :rails_health_check
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
