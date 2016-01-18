class CommentsController < ApplicationController
    before_action :authenticate_chef!
    before_action :set_recipe, only: [:create ]
    
    def new
        @comment = Comment.new()
    end
    
    def create
        @comment = Comment.new(comment_params)
        @comment.recipe =  @recipe
        @comment.chef = current_chef
        if @comment.save
            flash[:success] = "Uspešno ste dodali komentar"
            redirect_to @recipe
        else
            render 'new'
        end
    end
    
    def destroy
    end
    
    private
    
    def comment_params
        params.require(:comment).permit(:recipe_id, :chef_id, :comment)
    end
    
    def set_recipe
        @recipe = Recipe.find(params[:recipe_id])
    end

end
