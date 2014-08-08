class UsersController < InheritedResources::Base

  before_filter :authenticate_user_from_token!
  def show
    @user = current_user
  end

  def user_params
    params.require(:user).permit!
  end

end