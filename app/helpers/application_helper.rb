module ApplicationHelper
  def date_creation_time(item)
    item.created_at.strftime('%b %d, %Y')
  end

  def detailed_creation_time(item)
    item.created_at.strftime('%m-%e-%y %l:%M %p')
  end
end
