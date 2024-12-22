Rails.application.routes.draw do
  devise_for :users
  root to: "home#index" 
  resources :user_workouts
end