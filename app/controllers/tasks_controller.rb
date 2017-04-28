class TasksController < ApplicationController
	respond_to :html, :xml, :json
  	def index
  		@tasks = Task.where(user_id: current_user.id).all
  	end

  	def create
  		task = current_user.tasks.create(task_params)
  		respond_with task, json: task
  	end

  	def update
  		task = Task.find(params[:id])
  		task.update_attributes(update_params)
  		respond_with task, json: task
  	end

  	private

  	def task_params
  		params.require(:task).permit(:todo)
  	end

  	def update_params
  		params.require(:task).permit(:finished)
  	end
end
