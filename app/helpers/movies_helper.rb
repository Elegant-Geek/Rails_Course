module MoviesHelper
    def total_gross(movie)
        if movie.flop?
           "Flop" 
        #    ^^ NO "PUTS" IS NEEDED
        else
            number_to_currency(movie.total_gross, precision: 0)
        end
    end

    def year_of(movie)
        # movie.released_on.strftime("%Y")
        # not efficient ^^^
        movie.released_on.year
        # shortcut! ^^^
    end
end
