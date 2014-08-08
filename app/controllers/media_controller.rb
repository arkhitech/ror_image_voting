class MediaController < InheritedResources::Base
  
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  
  load_and_authorize_resource except: [:create]
  
  respond_to :json, :html, :xml
  
  def index
    @media = Medium.all
    #extname = File.extname(@media)[1..-1]
    #mime_type = Mime::Type.lookup_by_extension(extname)
    #content_type = mime_type.to_s unless mime_type.nil?
    respond_with(@media)
  end
  
  def new
    #@medium = current_user.build_medium
    @medium = Medium.new
    respond_with(@medium)  
  end
  
  def show
    @medium = Medium.find(params[:id])
    respond_with(@medium)
  end
  
  def create
    @medium = Medium.create(medium_params)
    @medium.user_id = current_user.id
    
    respond_with(@medium) do |format|
      if @medium.save
        format.html { redirect_to @medium, notice: 'Media was successfully created.' }
        format.json { render @medium }
      else
        format.html { render action: "new" }
        format.json { render @medium.error}
      end
    end
  end
  
  def destroy
    @medium = Medium.destroy(params[:id])
    respond_with(@medium)
  end
  
  def edit
    @medium = Medium.find(params[:id])
    respond_with(@medium)
  end
  
  def update
    @medium = Medium.update(params[:id],medium_params)
    respond_with(@medium)
  end
  
  private
  
  def medium_params
    params.require(:medium).permit!
  end
  
end
