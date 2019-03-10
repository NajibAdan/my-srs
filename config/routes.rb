# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get 'home', to: 'static_pages#home'
  get 'contact', to: 'static_pages#contact'
  get 'about', to: 'static_pages#about'
  get 'study', to: 'decks#study'
  get 'help', to: 'static_pages#help'
  post 'study', to: 'decks#study_receiver'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  resources :users
  resources :decks
  resources :cards
  resources :fronts, except: %i[show index]
  resources :backs, except: %i[show index]
  resources :tags
  resources :options
end
