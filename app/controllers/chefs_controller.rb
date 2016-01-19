class ChefsController < ApplicationController
    before_action :set_chef, only: [ :show ]
    #before_action :require_same_user, only: [ :edit, :update ]
    def index
        @chefs = Chef.paginate( page: params[:page], per_page: 6 )
    end
    
    def show
        @recipes = @chef.recipes.paginate( page: params[:page], per_page: 6 )
    end

    
    private
    
    def chef_params
        params.required(:chef).permit( :name, :email, :password )
    end
    
    def set_chef
        @chef = Chef.find_by_id(params[:id]) 
    end
    def require_same_user
       if current_chef != @chef
           flash[:danger] = "You can only edit your own profile"
           return_to root_path
       end
    end
end