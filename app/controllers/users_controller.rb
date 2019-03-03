# frozen_string_literal: true

class UsersController < ApplicationController
  include UsersHelper
  before_action :authenticate_user!
  before_action :correct_user, only: %i[edit update destroy]
  before_action :admin_only, only: %i[index destroy]
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "#{@user.name} was deleted successfully"
      redirect_to action: 'index'
    else
      flash[:alert] = 'An error occured when deleting'
      redirect_to root_url
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end
end
