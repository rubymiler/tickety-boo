class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy toggle_resolve set_faq public_show]

  load_and_authorize_resource

  def index
    @tickets = @tickets.includes(submitter: :avatar_attachment).order_by_submission.page(params[:page]).per(20)
  end

  def show; end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = current_user.submitted_tickets.create(ticket_params)

    if @ticket.save
      redirect_to @ticket, notice: 'Ticket created successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: 'Ticket updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path, notice: 'Ticket deleted'
  end

  def toggle_resolve
    @ticket.update(resolved: !@ticket.resolved)
    redirect_to @ticket
  end

  def set_faq
    if !@ticket.public && @ticket.answer.present?
      @ticket.update(public: true)
      redirect_to public_show_ticket_path(@ticket), notice: 'Successfully set ticket as FAQ'
    else
      redirect_to ticket_path(@ticket), alert: 'FAQ tickets must have an answer'
    end
  end

  def faq
    @tickets = Ticket.includes(:topics).published.search(params[:query]).page(params[:page]).per(10)
  end

  def public_show; end

  def pending
    @tickets = @tickets.unresolved.includes(submitter: :avatar_attachment).order_by_submission.page(params[:page]).per(20)
    render :index
  end

  def resolved
    @tickets = @tickets.resolved.includes(submitter: :avatar_attachment).order_by_submission.page(params[:page]).per(20)
    render :index
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title,
                                   :description,
                                   :attachment,
                                   :query,
                                   topic_ids:[],
                                   topics_attributes: %i[name _destroy id])
  end
end
