class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[show destroy edit update accept decline]
  before_action :set_ticket, only: %i[new create]
  load_and_authorize_resource

  def index; end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = @ticket.meetings.build(meeting_params)
    @meeting.requester = current_user
    @meeting.requestee = @ticket.submitter
    if @meeting.save
      MeetingMailer.with(meeting: @meeting).meeting_schedule_notification.deliver_later
      redirect_to @meeting, notice: 'Meeting requested'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    @meeting.status = 0
    if @meeting.update(meeting_params)
      MeetingMailer.status_update_notification(@meeting).deliver_later
      redirect_to @meeting, notice: 'Meeting updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @meeting.destroy
    redirect_to meetings_path, notice: 'Meeting deleted'
  end

  def accept
    @meeting.update(status: 1)
    redirect_to meetings_path
  end

  def decline
    @meeting.update(status: 2)
    redirect_to meetings_path
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def set_ticket
    unless @ticket = Ticket.find_by_id(params[:ticket_id])
      redirect_to tickets_path, alert: 'Could not find ticket'
    end
  end

  def meeting_params
    params.require(:meeting).permit(:start_time, :end_time)
  end
end
