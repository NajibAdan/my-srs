module UsersHelper
    private
    def admin_only
        if !current_user.admin?
            flash[:notice] = "Admins only"
            redirect_to user_session_url
        end
    end

    def user_params
        params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
    end

    def correct_user
        @user =  User.find(params[:id])
        redirect_to root_url unless (@user==current_user || current_user.admin?)
    end
end
