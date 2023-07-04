class FavoritesController < ApplicationController
    def create
       if @favorite = current_user.favorites.create(recipe_id: params[:recipe_id])
            redirect_back(fallback_location: root_path) 
       else
            redirect_to recipes_path
       end
    end

    def destroy
        if user_signed_in?
            @recipe = Recipe.find(params[:recipe_id])
            @favorite = current_user.favorites.find_by(recipe_id: @recipe.id)
            @favorite.destroy
            redirect_back(fallback_location: root_path)
        else
            redirect_to recipes_path
        end
    end

end
