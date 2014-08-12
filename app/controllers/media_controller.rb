class MediaController < InheritedResources::Base
  
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  
  load_and_authorize_resource except: [:create]
  
  respond_to :json, :html, :xml
  
  def index
    #@media = Medium.all
    @media = Medium.where(is_private: false).includes({slams: :medium_second})
    #@media = current_user.media.all
    respond_to do |format|
      format.json do
        render json: @media.as_json(include: [
                {slams: {
                  include: :medium_second,
                  methods: [:score]
                }},
                :comments
              ]
            )        
      end
      format.all {respond_with(@media)}
      
    end
    
  end
  
  def my_media
    @media = current_user.media.all
    respond_with(@media)
  end
  
  def new
    #@medium = current_user.build_medium
    @medium = Medium.new
    respond_with(@medium)  
  end
  
  def show
    @medium = Medium.find(params[:id])
    @comments = @medium.comments.all
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
