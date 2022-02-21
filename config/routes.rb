Rails.application.routes.draw do
  get "movies" => "movies#index"
  #The syntax for adding a route is a bit unorthodox, so here's a reminder of the generic format:
  #verb "url" => "name_of_controller#name_of_action"

end
