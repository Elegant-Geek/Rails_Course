class MoviesController < ApplicationController

    before_action :require_login, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]
    before_action :set_movie, only: [:show, :edit, :update, :destroy]


    def index #action name goes here, index in this case. (which is tied to the name.html.erb view template file)
        # @movies = ["Iron Man", "Superman", "Spider-Man", "Avengers"]
            case params[:filter]
            when "upcoming"
              @movies = Movie.upcoming
            when "recent"
              @movies = Movie.recent
            when "hits"
                @movies = Movie.hits
            when "flops"
                @movies = Movie.flops
            else
              @movies = Movie.released
            end
    end

    def show
        @genres = @movie.genres.order(:name)
        @fans = @movie.fans
        if current_user
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
        end
    end

    def edit
        # @movie = Movie.find(params[:id])
    end

    def update
        if @movie.update(movie_params)
            # flash[:notice] = "Movie successfully updated!"
            # redirect_to(movie_path(@movie))
            redirect_to @movie, notice: "Movie successfully updated!"
        else
            render :edit
        end 
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            redirect_to @movie, notice: "Movie successfully created!"
        else 
            render :new
        end 
    end

    def destroy
        @movie.destroy
        redirect_to movies_url, alert: "Movie successfully deleted!"
    end

    private
    def movie_params
        params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross,
                                :director, :duration, :main_image, genre_ids: [])
    end

    def set_movie
        @movie = Movie.find_by!(slug: params[:id])
      end
      #^^ set this to run before only the [:show, :edit, :update, :destroy] actions


end
 # ^^^^ Reminder to put private methods in the class not outside of it!


