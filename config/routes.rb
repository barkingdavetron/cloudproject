Rails.application.routes.draw do
  # routes for devise user authentication
  devise_for :users

  # sets the root path of the application to the HomeControllers index action
  root to: "home#index"

  # creates  routes for user_workouts 
  resources :user_workouts
end
