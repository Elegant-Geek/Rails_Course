Rails.application.routes.draw do

  
  resources :users
  root "movies#index"
  resources :movies do
    resources :reviews
  end
  get "signup" => "users#new"


  # get "movies" => "movies#index"
  # get "movies/:id" => "movies#show", as: "movie"
  # get "movies/:id/edit" => "movies#edit", as: "edit_movie"
  # patch "movies/:id" => "movies#update"

  #The syntax for adding a route is a bit unorthodox, so here's a reminder of the generic format:
  #verb "url" => "name_of_controller#name_of_action"

end
