module TicketsHelper
  def ticket_status(ticket)
    if ticket.resolved
      content_tag(:div, 'resolved', class: 'status status-green')
    else
      content_tag(:div, 'in progress', class: 'status status-yellow')
    end
  end

  def toggle_resolve_link(ticket)
    link_to toggle_resolve_ticket_path(ticket), class: 'lnk lnk-action', method: :post do
      ticket.resolved ? 'In Progress?' : 'Resolved?'
    end
  end

  def set_faq_link(ticket)
    if ticket.public
      content_tag(:p, 'This is an FAQ ticket.')
    else
      link_to 'Public?', set_faq_ticket_path(ticket), class: 'lnk lnk-action', method: :post
    end
  end
end
