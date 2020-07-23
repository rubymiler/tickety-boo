class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[show destroy toggle_accepted]
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
      redirect_to @meeting
    else
      render :new
    end
  end

  def show; end

  def destroy
    @meeting.destroy
  end

  def toggle_accepted
    @meeting.accepted = !@meeting.accepted
    @meeting.save
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
