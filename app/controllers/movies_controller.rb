class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def by_director
    if params[:director].present?
      @movies = Movie.where(director: params[:director])
    else
      @movies = Movie.all  # Fallback to show all movies if no director is specified
    end
    render :index  # Assuming you want to render the index view with the results
  end

  
  def similar
    @movie = Movie.find(params[:id])
    if @movie.director.present?
      # Find movies with the same director, excluding the current movie
      @similar_movies = Movie.where(director: @movie.director).where.not(id: @movie.id)
    else
      flash[:warning] = "'#{@movie.title}' has no director info"
      redirect_to movies_path and return
    end
  end

  

  private

  # Note - for Part 1, you may need to modify this method.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end
