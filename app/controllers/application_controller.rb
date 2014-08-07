class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:profile_picture_url) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:profile_picture_url) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
 
    def authenticate_active_admin_user!
        authenticate_admin_user!
        unless current_admin_user.role?(:superadmin) or current_admin_user.role?(:advertiser)
            flash[:alert] = "You are not authorized to access this resource!"
            redirect_to admin_root_path
        end
    end
end
