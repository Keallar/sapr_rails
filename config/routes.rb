Rails.application.routes.draw do
  root 'home#index'
  resources :preprocessor
  resources :postprocessor
  patch 'calculate', action: :calculate, controller: 'processor'
end

