class MembersController < InheritedResources::Base
  
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  
  load_and_authorize_resource except: [:create, :new]
  
  respond_to :json, :html, :xml
  
  
  
  def index
    if params[:user_group_id]
      @members = Member.where(user_group_id: params[:user_group_id])
    else
      @members = Member.all
    end
      respond_with(@members)
  end
  
  def new
    @member = Member.new(user_group_id: params[:user_group_id])
    respond_with(@member)
  end
  
  def show
    @member = Member.find(params[:id])
    respond_with(@member)
  end
  
  def create
    @member = Member.create(group_params)
    respond_with(@member) do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Successfully joined the group' }
        format.json { render @member }
      else
        format.html { render action: "new" }
        format.json { render @member.error}
      end
    end
  end
  
  def destroy
    @member = Member.destroy(params[:id])
    respond_with(@member)
  end
  
  
  private
  
  def group_params
    params.require(:member).permit!
  end
  
end

