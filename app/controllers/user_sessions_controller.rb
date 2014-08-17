class UserSessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token,
                     if: Proc.new { |c| c.request.format == 'application/json' }

  before_filter :authenticate_user_from_token!  
  
  def create
    respond_to do |format|
      format.json do
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        authentication_token = params[:authentication_token] || resource.reset_authentication_token
        render json: {
          authentication_token: authentication_token,
          id: resource.id
          }
      end
      format.all {super}      
    end
  end

  def destroy
    respond_to do |format|
      format.json {
        sign_out(resource_name)
        render json: {success: true}
      }
      format.all {super}
    end    
  end

  private
  
  def authenticate_user_from_token!
    return if params[:authentication_token].nil?    
    user_email = params[:user_email]
    user       = user_email && User.find_by_email(user_email)
 
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:authentication_token])
      sign_in user
    end
  end    
  
end
