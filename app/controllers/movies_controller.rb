class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_all_ratings
    
    #if params['commit'] == 'Refresh'
    #end
    #debugger
    if params[:sort_by] == nil
      @criteria = session[:criteria]
    else
      @criteria = params[:sort_by].to_s
      if params['commit']== 'Refresh'
        session[:criteria] = @criteria
      end
    end
    
    if params[:ratings] == nil
      @rates = session[:rates]
    else
      @rates = params[:ratings]
      if params['commit']== 'Refresh'
        session[:rates] = @rates
      end
    end
    
    @movies = Movie.where(:rating => @rates.keys).order(@criteria)
    if params['commit']!=nil
      redirect_to :ratings => @rates, :sort_by => @criteria
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    #redirect_to movies_path
    redirect_to :ratings => @rates, :sort_by => @criteria
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to :ratings => @rates, :sort_by => @criteria
  end
  
end
