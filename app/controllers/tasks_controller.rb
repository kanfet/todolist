class TasksController < ApplicationController

  respond_to :json

  def index
    tasks = []
    tasks = Task.where(user_id: current_user.id) if current_user
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