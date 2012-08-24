class TasksController < ApplicationController

  respond_to :json

  def index
    orders = []
    date_sort = params[:date_sort]
    if date_sort && (date_sort == "asc" || date_sort == 'desc')
      orders << "due_date #{date_sort}"
    end
    priority_sort = params[:priority_sort]
    if priority_sort && (priority_sort == "asc" || priority_sort == 'desc')
      orders << "priority #{priority_sort}"
    end

    tasks = []
    if current_user
      tasks = Task.where(user_id: current_user.id)
      tasks = tasks.order(orders.join(", ")) if orders.length > 0
    end
    respond_with(tasks)
  end

  def create
    task = Task.new(params[:task])
    task.user = current_user if current_user
    task.save
    respond_with(task)
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes(params[:task]) if current_user && current_user.id == task.user_id
    respond_with(task)
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy if current_user && current_user.id == task.user_id
    respond_with(:nothing)
  end
end