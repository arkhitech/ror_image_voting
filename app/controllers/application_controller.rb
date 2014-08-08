class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # This is Devise's authentication
  #before_filter :authenticate_user!
 
  private
  
  def authenticate_user_from_token!
    return if params[:authentication_token].nil?
    user_email = params[:user_email]
    user       = user_email && User.find_by_email(user_email)
 
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:authentication_token])
      sign_in user, store: false
    end
  end    
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
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
