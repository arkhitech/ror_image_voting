class UserPasswordsController < Devise::PasswordsController
  skip_before_filter :verify_authenticity_token,
                     if: Proc.new { |c| c.request.format == 'application/json' }  
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if request.format == Mime::JSON
      render json: resource
    else
      yield resource if block_given?

      if successfully_sent?(resource)
        respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
      else
        respond_with(resource)
      end
    end
  end
end