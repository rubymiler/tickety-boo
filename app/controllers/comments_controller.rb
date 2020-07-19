class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    redirect_to ticket_path(@ticket)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
