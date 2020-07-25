class TasksController < ApplicationController
  before_action :set_task, only: %i[update destroy]
  load_and_authorize_resource

  def index
    if params[:ticket_id] && @ticket = Ticket.find_by_id(params[:ticket_id])
      @tasks = @ticket.tasks
    end
  end

  def create
    unless @ticket = Ticket.find_by_id(params[:ticket_id])
      redirect_to tickets_path, alert: 'Could not find ticket'
    end

    @task = @ticket.tasks.build(task_params)
    @task.assigner = current_user
    redirect_to ticket_tasks_path(@ticket)
    flash.alert = 'Failed to create task' unless @task.save
  end

  def update
    if @task.update(task_params)
      # MeetingMailer.status_update_notification(@task).deliver_later
      redirect_to @task, notice: 'Task updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task deleted'
  end

  private

  def set_task
    @task = Meeting.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :completed, :assignee_id)
  end
end
