class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]
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

  def update
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.update(answer: @comment.body)
    redirect_to faq_tickets_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to ticket_path(params[:ticket_id])
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
