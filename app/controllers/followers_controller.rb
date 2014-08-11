class FollowersController < InheritedResources::Base
  
  
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  
  load_and_authorize_resource except: [:create]
  
  respond_to :json, :html, :xml
  
  
  
  def index
#    if params[:medium_id]
#      @slams = Slam.where(medium_first_id: params[:medium_id])
#    else
      @followers = Follower.where(user_id:current_user.id)
#    end    
    respond_with(@followers)
  end
  
  def get_following
    @following = Follower.where(follower_id:current_user.id)
    respond_with(@following)
  end

  
#  def new
#    @slam = Slam.new(medium_first_id: params[:medium_id])
#    respond_with(@slam)
#  end
#  
#  def show
#    @slam = Slam.find(params[:id])
#    respond_with(@slam)
#  end
#  
#  def create
#    @slam = Slam.create(slam_params)
#    respond_with(@slam) do |format|
#      if @slam.save
#        format.html { redirect_to @slam, notice: 'Slam was successfully created.' }
#        format.json { render @slam }
#      else
#        format.html { render action: "new" }
#        format.json { render @slam.error}
#      end
#    end
#  end
#  
#  def destroy
#    @slam = Slam.destroy(params[:id])
#    respond_with(@slam)
#  end
#   
#  
#  private
#  
#  def slam_params
#    params.require(:slam).permit!
#  end
  

end
