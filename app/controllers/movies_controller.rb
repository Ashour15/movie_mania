class MoviesController < ApplicationController

  def index
    if params[:actor_name].present?
      @movies = Movie.joins(:actors).where(actors: { name: params[:actor_name] }).distinct
    else
      #This can be enhanced 
      @movies = Movie.left_joins(:reviews).group(:id).order('AVG(reviews.stars) DESC')
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
