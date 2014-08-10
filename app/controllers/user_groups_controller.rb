class UserGroupsController < InheritedResources::Base
  
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  
  load_and_authorize_resource except: [:create]
  
  respond_to :json, :html, :xml
  
  
  
  def index
    @user_groups = current_user.user_groups.all
    respond_with(@user_groups)
  end
  
  def new
    @user_group = UserGroup.new
    respond_with(@user_group)
  end

  def create  
    
    @user_group = UserGroup.create(user_group_params)
    @user_group.user_id = current_user.id
    
    respond_with(@user_group) do |format|
      if @user_group.save
        format.html { redirect_to @user_group, notice: 'Group was successfully created.' }
        format.json { render @user_group }
      else
        format.html { render action: "new" }
        format.json { render @user_group.error}
      end
    end
  end
  
  def show
    @user_group = UserGroup.find(params[:id])
    respond_with(@user_group)
  end
  
  def edit
    @user_group = UserGroup.find(params[:id])
    respond_with(@user_group)
  end
  
  def update
    @user_group = UserGroup.update(params[:id],user_group_params)
    respond_with(@user_group)
  end

  
  def destroy
    @user_group = UserGroup.destroy(params[:id])
    respond_with(@user_group)
  end
  
  
  private
  
  def user_group_params    
    params.require(:user_group).permit(:group_name, :user_id)
  end
  
end

