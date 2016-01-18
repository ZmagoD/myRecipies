class PagesController < ApplicationController
    
    def home
        if chef_signed_in?
            redirect_to recipes_path
        else
            @last_recipes = Recipe.last_recipes    
        end
    end
end
