Rottenpotatoes::Application.routes.draw do
  resources :movies
  get 'by_director', to: 'movies#show_by_director', as: 'by_director'
  
  
  get '/movies/:id/similar', to: 'movies#similar', as: 'similar_movies'

  # Add new routes here

  root :to => redirect('/movies')
end
