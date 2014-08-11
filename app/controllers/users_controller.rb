class UsersController < InheritedResources::Base

  before_filter :authenticate_user_from_token!
  
  def index
    @users = User.all
    respond_with(@users)
  end
  
  def follow
    @user = User.find(params[:id])
    @user = Follower.create(user_id: params[:id], follower_id: current_user.id)
    @user.save
    flash[:notice] = "Following user now"
    redirect_to :back
  end
  
  def unfollow
    @follower = Follower.where(user_id: params[:id], follower_id: current_user.id)
    @follower.destroy_all
    flash[:notice] = "Unfollowing user now"
    redirect_to :back
  end
  
  def show
    @user = current_user
  end

  def user_params
    params.require(:user).permit!
  end

end