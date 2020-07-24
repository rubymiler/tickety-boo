module MeetingsHelper
  def set_meeting_with(meeting)
    current_user == meeting.requester ? meeting.requestee.name : meeting.requester.name
  end

  def show_requestee_meeting_actions(meeting)
    return unless current_user == meeting.requestee && meeting.requested?

    render 'meetings/shared/requestee_actions', meeting: meeting
  end

  def show_requester_meeting_actions(meeting)
    return unless current_user == meeting.requester

    render 'meetings/shared/requester_actions', meeting: meeting
  end

  def show_meeting_datetime(datetime)
    datetime.strftime('%A, %b %d at %l:%M %p')
  end

  def show_meeting_time(datetime)
    datetime.strftime('%l: %M %p')
  end

  def show_meeting_on_index(meeting)
    link_to meeting_path(meeting) do
      content_tag(:p, "#{show_meeting_time(meeting.start_time)} to #{show_meeting_time(meeting.end_time)}", class: "meeting-#{meeting.status}") 
    end
  end
end
