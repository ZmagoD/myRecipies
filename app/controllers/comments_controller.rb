class CommentsController < ApplicationController
    before_action :set_recipe, only: [:create]
    before_action :require_user_comment
    
    def new
        @comment = Comment.new()
    end
    
    def create
        @comment = Comment.new(comment_params)
        @comment.recipe =  @recipe
        @comment.chef = current_user
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
    
    def require_user_comment
        if !logged_in?
           flash[:danger] = "Preden dodate komentar se morate prijaviti"
           redirect_to set_recipe
        end
    end
end
