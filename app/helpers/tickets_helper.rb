module TicketsHelper
  def ticket_status(ticket)
    if ticket.resolved
      content_tag(:p, 'resolved')
    else
      content_tag(:p, 'in progress')
    end
  end

  def ticket_creation_time(ticket)
    ticket.created_at.strftime('%b %d, %Y')
  end
end
