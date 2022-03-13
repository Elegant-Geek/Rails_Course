class ReviewsController < ApplicationController


    before_action :set_movie
    # "set movie" private method is done before all of these actions
    # code duplication is eliminated this way.
    # before adding the "before_action" at the top here,
    # @movie = Movie.find(params[:movie_id]) was the first line of code in every action.
    # Goal was to define a private method to eliminate this duplication

    def index
        @reviews = @movie.reviews
    end

    def new
        @review = @movie.reviews.new
    end

    def create
        @review = @movie.reviews.new(review_params)
        if @review.save
            redirect_to movie_reviews_url(@movie), notice: "Thanks for your review!"
        else 
            render :new
        end 
    end

    def edit
        @review = Review.find(params[:id])
    end

    def update
        @review = Review.find(params[:id])
        if @review.update(review_params)
            # flash[:notice] = "Movie successfully updated!"
            # redirect_to(movie_path(@movie))
            redirect_to (movie_reviews_path(@movie)), notice: "Review successfully updated!"
        else
            render :edit
        end 
    end

    def destroy
        @review = Review.find(params[:id])
        @review.destroy
        redirect_to (movie_reviews_path(@movie)), alert: "Review successfully deleted!"
    end
end

private
def review_params
  params.require(:review).permit(:name, :comment, :stars)
end
def set_movie
    @movie = Movie.find(params[:movie_id])
end