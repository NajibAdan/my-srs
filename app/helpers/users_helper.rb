module UsersHelper
    private
    def admin_only
        if !current_user.admin?
            flash[:notice] = "Admins only"
            redirect_to current_user
        end
    end
end
