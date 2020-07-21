module ApplicationHelper
  def date_creation_time(item)
    item.created_at.strftime('%m/%d/%Y')
  end

  def detailed_creation_time(item)
    item.created_at.strftime('%m-%e-%y %l:%M %p')
  end

  def show_meeting_time(time)
    time.strftime('%A, %b %d at %l:%M %p')
  end
end
