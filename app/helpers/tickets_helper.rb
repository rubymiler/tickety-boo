module TicketsHelper
  def ticket_status(ticket)
    if ticket.resolved
      content_tag(:div, 'resolved', class: 'status status-green')
    else
      content_tag(:div, 'in progress', class: 'status status-yellow')
    end
  end

  def toggle_resolve_link(ticket)
    link_to toggle_resolve_ticket_path(ticket), method: :post do
      if ticket.resolved
        'In Progress?'
      else
        'Resolved?'
      end
    end
  end
end
