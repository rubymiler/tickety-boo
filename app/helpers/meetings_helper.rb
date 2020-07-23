module MeetingsHelper
  def set_meeting_with(user, meeting)
    user == meeting.requester ? meeting.requestee.name : meeting.requester.name
  end

  def show_meeting_datetime(datetime)
    datetime.strftime('%A, %b %d at %l:%M %p')
  end

  def show_meeting_time(datetime)
    datetime.strftime('%l: %M %p')
  end
end
