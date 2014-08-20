# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class CommentsController < InheritedResources::Base
  skip_before_filter :verify_authenticity_token,
                     if: Proc.new { |c| c.request.format == 'application/json' }
  
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  
  load_and_authorize_resource except: [:create]
  
  respond_to :json, :xml, :html
  
  def create
    medium = Medium.find(params[:medium_id])
    @comment = medium.comments.build(comment_params)
    @comment.user_id = current_user.id
    #@medium.comments << Medium.new(comment_params)
    
    respond_with(@comment) do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Comment saved!' }
        format.json { render json: @comment }
      else
        redirect_to action: :show, id: params[:id], error: 'Error saving comment'
        format.html { redirect_to action: :show, id: params[:id], error: 'Error saving comment' }
        format.json { render json: @comment.errors}
      end
      #respond_with(@medium)
    end
  end
  
  def index
    medium = Medium.find(params[:medium_id])
    render json: {comments: medium.comments.as_json}
  end
  
  def destroy
    medium = Medium.find(params[:medium_id])
    comment = medium.comments.find(params[:id])
    comment.destroy
    redirect_to :back, notice: 'Comment deleted!'
  end
  protected
  
  def comment_params
    #params.require(:comment).permit[:title,:comment,:user_id]
    params.require(:comment).permit!
  end
end
