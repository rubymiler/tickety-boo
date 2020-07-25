class TasksController < ApplicationController
  before_action :set_task, only: %i[update destroy]
  load_and_authorize_resource

  def index
    if params[:ticket_id]
      if @ticket = Ticket.find_by_id(params[:ticket_id])
        @tasks = @ticket.tasks
      else
        redirect_to tickets_path, alert: 'Could not find ticket'
      end
    else
      load_aggregate_tasks
    end
  end

  def create
    if params[:ticket_id] && @ticket = Ticket.find_by_id(params[:ticket_id])
      @task = @ticket.tasks.build(task_params)
      @task.assigner = current_user
      if @task.save
        redirect_to ticket_tasks_path(@ticket)
      else
        redirect_to ticket_tasks_path(@ticket), alert: 'Task must have description and be assigned to an agent'
      end
    else
      redirect_to tickets_path, alert: 'Could not find ticket'
    end
  end

  def update
    @task.update(task_params)
    nested_reroute
  end

  def destroy
    @task.destroy
    nested_reroute
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def nested_reroute
    if params[:ticket_id]
      find_ticket
    else
      load_aggregate_tasks
    end
  end

  def find_ticket
    if @ticket = Ticket.find_by_id(params[:ticket_id])
      redirect_to ticket_tasks_path(@ticket)
    else
      redirect_to tickets_path, alert: 'Could not find ticket'
    end
  end

  def load_aggregate_tasks
    @tickets = current_user.tasked_tickets
    render :aggregate_index
  end

  def task_params
    params.require(:task).permit(:description, :completed, :assignee_id)
  end
end
