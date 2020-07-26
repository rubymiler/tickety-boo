class MeetingMailer < ApplicationMailer
  add_template_helper(MeetingsHelper)

  def meeting_schedule_notification(meeting)
    @meeting = meeting
    mail(to: @meeting.requestee.email, subject: "#{@meeting.requester.name} Requested a Meeting With You")
  end

  def status_update_notification(meeting)
    @meeting = meeting
    mail(to: meeting.requestee.email, subject: "#{meeting.requester.name} Updated a Meeting With You")
  end

end
