class SlamsController < InheritedResources::Base
  
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  
  load_and_authorize_resource except: [:create, :new]
  #load_and_authorize_resource through: :media
  
  respond_to :json, :html, :xml
  
  
  
  def index
    if params[:medium_id]
      @slams = Slam.where(medium_first_id: params[:medium_id]).
        includes({medium_first: :user}, {medium_second: :user})
    else
      @slams = Slam.all.includes({medium_first: :user}, {medium_second: :user})
    end    
    respond_with(@slams) do |format|
      format.json {render json: @slams.as_json(include: {
            medium_first: {include: :user},
            medium_second: {include: :user}})}
    end
  end
  
  def new
    @slam = Slam.new(medium_first_id: params[:medium_id])
    respond_with(@slam)
  end
  
  def show
    @slam = Slam.find(params[:id])
    respond_with(@slam)
  end
  
  def create
    @slam = Slam.create(slam_params)
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
  
  def slam_params
    params.require(:slam).permit!
  end
  
end


