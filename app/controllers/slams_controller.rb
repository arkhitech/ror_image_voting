class SlamsController < InheritedResources::Base
  
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  
  load_and_authorize_resource
  
  respond_to :json, :html, :xml
  
  
  
  def index
    @slams = Slam.all
    respond_with(@slams)
  end
  
  def new
    @slam = Slam.new
    respond_with(@slam)
  end
  
  def show
    @slam = Slam.find(params[:id])
    respond_with(@slam)
  end
  
  def create
    @slam = Slam.create(group_params)
    respond_with(@slam) do |format|
      if @slam.save
        format.html { redirect_to @slam, notice: 'Slam was successfully created.' }
        format.json { render @slam }
      else
        format.html { render action: "new" }
        format.json { render @slam.error}
      end
    end
  end
  
  def destroy
    @slam = Slam.destroy(params[:id])
    respond_with(@slam)
  end
  
  
  private
  
  def group_params
    params.require(:slam).permit!
  end
  
end


