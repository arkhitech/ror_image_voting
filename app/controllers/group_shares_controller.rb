class GroupSharesController < InheritedResources::Base
  
  before_filter :authenticate_user!
  
  load_and_authorize_resource
  
  respond_to :json, :html, :xml
  
  
  
  def index
    @group_shares = GroupShares.all
    respond_with(@group_shares)
end
  
  def new
    @group_share = GroupShares.new
    respond_with(@group_share)
  end
  
  def show
    @group_share = GroupShares.find(params[:id])
    respond_with(@group_share)
  end
  
  def create
    @group_share = GroupShares.create(group_share_params)
    respond_with(@group_share) do |format|
      if @group_share.save
        format.html { redirect_to @group_share, notice: 'User was successfully created.' }
        format.json { render @group_share }
      else
        format.html { render action: "new" }
        format.json { render @group_share.error}
      end
    end
  end
  
  def destroy
    @group_share = GroupShares.destroy(params[:id])
    respond_with(@group_share)
  end
  
  
  private
  
  def group_share_params
    params.require(:group_share).permit!
  end
  
end
