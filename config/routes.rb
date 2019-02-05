Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get 'home', to: 'static_pages#home'
  get 'contact', to: 'static_pages#contact'
  get 'about', to: 'static_pages#about'
  get 'study', to: 'decks#study'
  post 'study', to: 'decks#study_receiver'
  resources :users
  resources :decks
  resources :cards
  resources :fronts, except: [:show,:index]
  resources :backs, except: [:show,:index]
end
