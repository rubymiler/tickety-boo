class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[show destroy toggle_accepted]
  load_and_authorize_resource

  def index; end

  def new
    @meeting = Meeting.new
    @ticket = Ticket.find(params[:ticket_id])
  end

  def create
    @ticket = Ticket.find(params[:ticket_id])
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

  def meeting_params
    params.require(:meeting).permit(:start_time, :end_time)
  end
end
