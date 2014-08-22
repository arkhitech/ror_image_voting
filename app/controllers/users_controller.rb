class UsersController < InheritedResources::Base
    skip_before_filter :verify_authenticity_token,
                     if: Proc.new { |c| c.request.format == 'application/json' }

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
    #@user.save
    if @user.save
      flash[:notice] = "Following user now"
    else
      flash[:notice] = @user.errors.full_messages.join("\n")      
    end
      redirect_to :back
    
  end
  
  def unfollow
    @follower = Follower.where(user_id: params[:id], follower_id: current_user.id)
    if(@follower.any?)
      @follower.destroy_all
      flash[:notice] = "Unfollowing user now"
    else
      flash[:notice] = "Already not following!"
    end
    redirect_to :back
  end
  
  def edit
    @user = current_user
    respond_with(@user)
  end
  
  def update
    @user = User.update(current_user.id,user_params)
    respond_with(@user)
  end
  
  def show
    if params[:id] == '0'
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