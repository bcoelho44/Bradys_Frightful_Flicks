class HomeController < ApplicationController
  def index
    @featured_products = Movie.limit(6) # Example: Display 6 featured movies
    @categories = Subgenre.all # Display all categories (subgenres)
  end
end
