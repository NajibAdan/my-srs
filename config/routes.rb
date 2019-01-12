Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get 'home', to: 'static_pages#home'
  get 'contact', to: 'staticpages#contact'
  get 'about', to: 'staticpages#about'
  resources :users
end
