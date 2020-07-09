class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all.public
  end

  def show
    @ticket = Ticket.find(params[:id])
  end
end
