# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class CommentsController < InheritedResources::Base
  
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  
  load_and_authorize_resource except: [:create]
  
  def create
    medium = Medium.find(params[:medium_id])
    comment = medium.comments.build(comment_params)
    comment.user_id = current_user.id
    #@medium.comments << Medium.new(comment_params)
    if comment.save
      redirect_to :back, notice: 'Comment saved!'
    else
      redirect_to action: :show, id: params[:id], error: 'Error saving comment'
    end
    #respond_with(@medium)
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
