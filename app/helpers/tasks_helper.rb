module TasksHelper
  def ticket_task_link(ticket)
    link_to ticket_tasks_path(@ticket.id), class: 'lnk lnk-action' do
      ticket.tasks.present? ? "Check this ticket's tasks" : 'Start new tasks'
    end
  end

  def load_task_collection(ticket)
    ticket.tasks.where('assigner_id = ? OR assignee_id = ?', current_user.id, current_user.id)
  end
end
