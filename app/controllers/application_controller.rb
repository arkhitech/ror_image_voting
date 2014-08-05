class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
    def authenticate_active_admin_user!
        authenticate_admin_user!
        unless current_admin_user.role?(:superadmin) or current_admin_user.role?(:advertiser)
            flash[:alert] = "You are not authorized to access this resource!"
            redirect_to admin_root_path
        end
    end
end
