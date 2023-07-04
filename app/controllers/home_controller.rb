class HomeController < ApplicationController
    def index
        @ranks = Recipe.find(Favorite.group(:recipe_id).order('count(recipe_id) DESC').limit(9).pluck(:recipe_id))
    end
end
