class TasksController < ApplicationController
    before_filter :authenticate_user!
	  respond_to :html, :xml, :json
  	def index
  		@tasks = Task.where(user_id: current_user.id).notfinish.published
  		@task_finish = Task.where(user_id: current_user.id).finish.published
        @task_last_id = Task.last
  	end

  	def create
  		task = current_user.tasks.create(task_params)
        task.create_activity :create, owner: current_user
  		respond_with task, json: task
  	end

  	def update
  		task = Task.find(params[:id])
  		task.update_attributes(update_params)
        task.create_activity :update, owner: current_user
  		respond_with task, json: task
  	end

  	private

  	def task_params
  		params.require(:task).permit(:todo, :expire)
  	end

  	def update_params
  		params.require(:task).permit(:finished, :published)
  	end
end
