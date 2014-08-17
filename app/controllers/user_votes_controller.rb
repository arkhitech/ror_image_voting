class UserVotesController < InheritedResources::Base
  
 before_filter :authenticate_user!
  
  load_and_authorize_resource
  
  respond_to :json, :html, :xml
  
  
  
  def index
    #@user_votes = UserVote.all
    @user_votes = UserVote.where(slam_id: params[:slam_id])
    respond_with(@user_votes)
  end
  
  def new
    @user_vote = UserVote.new
    respond_with(@user_vote)
  end
  
  def show
    @user_vote = UserVote.find(params[:id])
    respond_with(@user_vote)
  end
  
  def create
    @user_vote = UserVote.create(group_params)
    respond_with(@user_vote) do |format|
      if @user_vote.save
        format.html { redirect_to @user_vote, notice: 'UserVote was successfully created.' }
        format.json { render @user_vote }
      else
        format.html { render action: "new" }
        format.json { render json: @user_vote.errors}
      end
    end
  end
  
  def destroy
    @user_vote = UserVote.destroy(params[:id])
    respond_with(@user_vote)
  end
  
  def first_liked
    apply_user_vote(true)
  end
  
  def second_liked
    apply_user_vote(false)
  end
  
  private

  def apply_user_vote(vote_status)
    @user_vote = current_user.user_votes.where(slam_id: params[:slam_id])
    unless @user_vote
      @user_vote.vote_status = vote_status
      @user_vote.save
    else
      @user_vote = UserVote.create(slam_id: params[:slam_id], vote_status: vote_status, user_id: current_user.id)   
    end
    respond_with(@user_vote) do	|format|
      format.html { 
        if @user_vote.errors
          flash[:notice] = @user_vote.errors.full_messages.join("\n")
        end
        redirect_to :back 
      }
      format.json {
        if @user_vote.errors
          render json: @user_vote.errors
        else
          render json: @user_vote
        end
      }
    end
  end
  
  def group_params
    params.require(:user_vote).permit!
  end
  
end

