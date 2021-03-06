class RecipesController < ApplicationController
    before_action :set_recipe, only: [ :edit, :update, :show, :like ]
    before_action :authenticate_chef!, except: [ :show, :index, :like, :search ] 
    before_action :require_user_like, only: [ :like ]
    before_action :require_same_user, only: [ :edit, :update ]
    
    def index
        @recipes = Recipe.paginate( page: params[:page], per_page: 8 )
    end
    
    def show
    end
    
    def new
        @recipe = Recipe.new
    end
    
    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.chef = current_chef
        
        if @recipe.save
            flash[:success] = "Your recipe was created successfully!"
            redirect_to recipes_path
        else
            render :new
        end
            
    end
    
    def edit
    end
    
    def update
        if @recipe.update(recipe_params)
            flash[:success] = "Your recipe was successfully updated!"
            redirect_to recipes_path(@recipe)
        else
            render :edit
        end
    end
    
    def like
        like = Like.create(like: params[:like], chef: current_chef, recipe: @recipe )
        if like.valid?
            flash[:success] = "Your selection was successful"
            redirect_to :back
        else
            flash[:danger] = "You can only like/dislike recipe once"
            redirect_to :back
        end
    end
    
    def destroy
        Recipe.find(params[:id]).destroy
        flash[:success] = "Recipe deleted"
        redirect_to recipes_path
    end
    
    def search
        @recipes = Recipe.search_by_name(params[:search_recipe]).paginate( page: params[:page], per_page: 8 )
    end
    
    private
    
        def recipe_params
            params.require(:recipe).permit( :name, :summary, :description, :picture, style_ids: [], ingredient_ids: [] )
        end
        
        def set_recipe
            @recipe = Recipe.find_by_id(params[:id]) 
        end
        
        def require_same_user
            if current_chef != @recipe.chef 
                flash[:danger] = "You can only edit your recipes"
                redirect_to recipes_path
            end
        end
        
        def require_user_like
            if !chef_signed_in?
              flash[:danger] = "You must be logged in to perform the action"
              redirect_to :back
            end
        end
        
end
