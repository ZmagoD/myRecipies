class PagesController < ApplicationController
    
    def home
        if logged_in?
            redirect_to recipes_path
        else
            @last_recipes = Recipe.last_recipes    
        end
    end
end
