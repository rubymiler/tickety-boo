module MeetingsHelper
  def set_meeting_with(user, meeting)
    user == meeting.requester ? meeting.requestee.name : meeting.requester.name
  end

  def show_meeting_time(time)
    time.strftime('%A, %b %d at %l:%M %p')
  end
end
