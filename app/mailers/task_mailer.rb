class TaskMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
  	def new_task_email(user, task)
    	@user = user
    	@task = task
    	@url  = 'https://todo-with-rails-5.herokuapp.com/'
    	mail(to: @user.email, subject: 'New Task Assigned By Admin')
  	end
end
