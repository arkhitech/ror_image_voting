class UserRegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
  
  def create
    if request.format == Mime::JSON
      build_resource(sign_up_params)

      resource_saved = resource.save
      yield resource if block_given?
      if resource_saved
        render json: resource.as_json(authorization_token: resource.authentication_token), status: 201
      else
        warden.custom_failure!
        render json: resource.errors, status: 422
      end
    else
      super
    end
  end
  
#  private
#  #overriding devise params
#  def sign_up_params
#    params.require(:user).permit(:username, :email, :password, :password_confirmation)
#  end
# 
#  def account_update_params
#    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
#  end
end
