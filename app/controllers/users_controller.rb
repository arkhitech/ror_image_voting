class UsersController < InheritedResources::Base

  before_filter :authenticate_user_from_token!
  
  before_filter :authenticate_user!
  
  load_and_authorize_resource except: [:create]
  
  respond_to :json, :html, :xml
  
  def index
    @users = User.all
    
    respond_to do |format|
     format.json do
        render json: @users.as_json(
          methods: :slams_count
         )
      end
       format.all {respond_with(@users)}
   end
  
  #  respond_with(@users)
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
  
  def edit
    @user = current_user
    respond_with(@user)
  end
  
  def update
    @user = User.update(user_params)
    respond_with(@user)
  end
  
  def show
    if params[:id] == 'me'
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    respond_with(@user)
  end

  def user_params
    params.require(:user).permit!
  end

end