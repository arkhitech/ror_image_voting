class VotesController < InheritedResources::Base
  
 before_filter :authenticate_user!
  
  load_and_authorize_resource
  
  respond_to :json, :html, :xml
  
  
  
  def index
    @votes = Vote.all
    respond_with(@votes)
  end
  
  def new
    @vote = Vote.new
    respond_with(@vote)
  end
  
  def show
    @vote = Vote.find(params[:id])
    respond_with(@vote)
  end
  
  def create
    @vote = Vote.create(group_params)
    respond_with(@vote) do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render @vote }
      else
        format.html { render action: "new" }
        format.json { render @vote.error}
      end
    end
  end
  
  def destroy
    @vote = Vote.destroy(params[:id])
    respond_with(@vote)
  end
  
  
  private
  
  def group_params
    params.require(:vote).permit!
  end
  
end

