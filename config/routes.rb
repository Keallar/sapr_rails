Rails.application.routes.draw do
  root 'home#index'
  resources :preprocessor
  resources :postprocessor
end

