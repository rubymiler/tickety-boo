class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all.public
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = current_user.submitted_tickets.create(ticket_params)

    if @ticket.save
      redirect_to @ticket, notice: 'Ticket created successfully.'
    else
      render :new, alert: 'Could not create your ticket.'
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: 'Ticket updated successfully.'
    else
      render :edit, alert: 'Could not update ticket.'
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end
