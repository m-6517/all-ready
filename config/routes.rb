Rails.application.routes.draw do
  root "static_pages#top"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :recommends do
    get "place/:place", to: "recommends#by_place", as: "by_place", on: :collection
  end

  resources :item_lists do
    resources :items, only: %i[new create update destroy] do
      post :new_original_item, on: :collection
      delete "destroy_original_item/:id", action: :destroy_original_item, as: :destroy_original_item
    end
    resources :quantities, only: %i[index edit update]
    
    post :duplicate, on: :member
    patch :clear_checked_items, on: :member
    patch :update_position, on: :member
  end

  resources :bag_contents

  resources :item_statuses, only: %i[update] do
    patch :toggle, on: :member
    patch :sort, on: :member
  end

  resource :profile, only: %i[show edit update]

  resources :bookmarks, only: %i[index create destroy]

  get "form", to: "static_pages#form", as: "inquiry_form"
  get "policy", to: "static_pages#policy", as: "privacy_policy"
  get "terms", to: "static_pages#terms", as: "terms"
  get "how_to_use", to: "static_pages#how_to_use", as: "how_to_use"

  get "images/ogp.png", to: "images#ogp", as: "images_ogp"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
