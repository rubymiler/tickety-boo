class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]
  before_action :set_ticket, only: %i[create update]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.update(commented_ticket: @ticket)
      redirect_to ticket_path(@ticket)
    else
      render 'tickets/show', alert: 'Failed to create comment'
    end
  end

  def update
    @ticket.update(answer: @comment.body)
    redirect_to public_show_ticket_path(@ticket)
  end

  def destroy
    @comment.destroy
    redirect_to @ticket
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_ticket
    unless @ticket = Ticket.find_by_id(params[:ticket_id])
      redirect_to tickets_path, alert: 'Could not find ticket'
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
