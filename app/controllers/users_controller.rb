class UsersController < ApplicationController
    include UsersHelper
    before_action :authenticate_user!
    before_action :correct_user, only: [:edit, :update,:destroy]
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
            flash[:success] = "#{@user.name} was deleted successfully"
            redirect_to action: "index"
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "Profile updated"
            redirect_to @user
        else
            render 'edit'
        end
    end
end
