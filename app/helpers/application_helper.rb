module ApplicationHelper
  def date_creation_time(item)
    item.created_at.strftime('%m/%d/%Y')
  end

  def detailed_creation_time(item)
    item.created_at.strftime('%m-%e-%y %l:%M %p')
  end

  def show_notification
    if notice || alert
      render 'shared/notification'
    end
  end

  def display_notice
    tag.p(notice, class: 'notice') if notice
  end

  def display_alert
    tag.p(alert, class: 'alert') if alert
  end
end
