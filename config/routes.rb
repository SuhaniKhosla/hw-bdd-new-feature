Rottenpotatoes::Application.routes.draw do
  resources :movies
  get 'by_director', on: :collection  
  end
  # Add new routes here

  root :to => redirect('/movies')
end
