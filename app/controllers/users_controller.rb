class UsersController < ApplicationController
    include UsersHelper
    before_action :authenticate_user!
    before_action :admin_only, only: [:index,:destroy]
    def show 
        @user = User.find(params[:id])
    end

    def index
        @users = User.all
    end

    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            flash[:notice] = "#{@user.name} was deleted successfully"
            redirect_to action: "index"
        end
    end
end
