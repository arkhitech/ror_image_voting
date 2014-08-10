class UserSessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  def create
    respond_to do |format|
      format.json do
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)              
        render json: {authentication_token: resource.reset_authentication_token}
      end
      format.all {super}      
    end
  end

  def destroy
    respond_to do |format|
      format.json {
        sign_out(resource_name)
        render json: {sucess: true}
      }
      format.all {super}
    end    
  end

end
