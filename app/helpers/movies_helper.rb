module MoviesHelper

    def main_image(movie)
      if movie.main_image.attached?
        # image_tag movie.main_image.variant(resize_to_limit: [150, 150], monochrome:true)
        image_tag movie.main_image
      else
        image_tag "placeholder.png"
      end
    end

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
#highlight the active nav link the user is on!
    def nav_link_to(text, url)
        if current_page?(url) #current_page? is a built in helper method
          link_to(text, url, class: "active")
        else
          link_to(text, url)
        end
      end

    # (optional helper that got commented out /replaced in both show.html.erb and index.html.erb)
    # if using this helper on either the show and/or index page, comment out the render line that follows /replaces it!
    
    # def average_stars(movie)
    #     if movie.average_stars.zero?
    #       content_tag(:strong, "No reviews")
    #     else
    #         "*" * movie.average_stars.round
    #     end
    # end

end


