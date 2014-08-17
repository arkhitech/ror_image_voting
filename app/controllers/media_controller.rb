class MediaController < InheritedResources::Base
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
  
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
                :comments, :user                
              ],
              methods: :likes_count
            )        
      end
      format.all {respond_with(@media)}
      
    end
    
  end
  
  def my_media
    @media = current_user.media.all
    respond_with(@media)
  end
  
  def like
    media = Medium.find(params[:medium_id])
    media.liked_by current_user
    redirect_to :back, notice: 'Liked!'
  end
  
  def dislike
    media = Medium.find(params[:medium_id])
    media.disliked_by current_user
    redirect_to :back, notice: 'DisLiked!'
  end
  
  def unlike
    media = Medium.find(params[:medium_id])
    media.unliked_by current_user
    redirect_to :back, notice: 'Unliked!'
  end
  
  def undislike
    media = Medium.find(params[:medium_id])
    media.undisliked_by current_user
    redirect_to :back, notice: 'UndisLiked!'
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
        format.json { render json: @medium }
      else
        format.html { render action: "new" }
        format.json { render json: @medium.errors}
      end
    end
  end
  
  def destroy
    @medium = Medium.destroy(params[:id])
    respond_with(@medium)
  end
  
  def challenge
    medium = Medium.find(params[:id])
    friends = User.where(id: params[:friends])
    friends.each do |friend|
      Mailer.challenge_friend(current_user, friend, medium).deliver
    end
    render json: friends    
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
