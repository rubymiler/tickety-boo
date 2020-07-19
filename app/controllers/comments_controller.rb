class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @ticket = Ticket.find(params[:ticket_id])
    @comment.commented_ticket = @ticket
    if @comment.save
      redirect_to ticket_path(@ticket)
    else
      render 'tickets/show', alert: 'Failed to create comment'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to ticket_path(params[:ticket_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
