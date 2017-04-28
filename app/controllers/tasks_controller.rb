class TasksController < ApplicationController
	  respond_to :html, :xml, :json
  def index
  end

  def create
  	task = current_user.tasks.create(task_params)
  	respond_with task, json: task
  end

  private

  def task_params
  	params.require(:task).permit(:todo)
  end
end
