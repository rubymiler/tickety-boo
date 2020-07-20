class MeetingsController < ApplicationController
  before_action :set_meeeting, only: %i[show edit update destroy]
  load_and_authorize_resource

  def index; end

  def new
    @meeting = Meeting.new
  end

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @meeting = Meeting.build(meeting_params)
    @meeting.ticket = @ticket
    @meeting.requester = current_user
    @meeting.requestee = @ticket.submitter
    if @meeting.save
      redirect_to @meeting
    else
      render :new, alert: 'Could not create meeting.'
    end
  end

  def show; end

  def edit; end

  def update
    if @meeting.update(meeting_params)
      redirect_to @meeting
    else
      render :edit, alert: 'Could not update meeting.'
    end
  end

  def destroy
    @meeting.destroy
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:start_time, :end_time)
  end
end
