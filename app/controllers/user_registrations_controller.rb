class UserRegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  def create
    respond_to do |format|
      format.json do
        build_resource(sign_up_params)
        
        resource_saved = resource.save
        yield resource if block_given?
        if resource_saved
          render json: resource.as_json(authorization_token: resource.authentication_token), status: 201
        else
          warden.custom_failure!
          render json: resource.errors, status: 422
        end
        format.all {super}      
      end
    end
  end
  
#  def user_params
#    params.require(:user).permit(:email, :password, :password_confirmation)
#  end  
end
