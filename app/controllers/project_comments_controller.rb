class ProjectCommentsController < ApplicationController
	def index
		@task_comment = ProjectComment.lumniStart(params,current_company)
		taskCommentResult = @task_comment.lumniSave(params,current_user)
		lumniClose(@task_comment,taskCommentResult)
	end

	def new
		@task_comment = ProjectComment.lumniStart(params,current_company)
		taskCommentResult = @task_comment.lumniSave(params,current_user)
		lumniClose(@task_comment,taskCommentResult)
	end

	def create
		@task_comment = ProjectComment.lumniStart(params,current_company)
		taskCommentResult = @task_comment.lumniSave(params,current_user)
		lumniClose(@task_comment,taskCommentResult)
	end

	def edit
		@task_comment = ProjectComment.lumniStart(params,current_company)
		taskCommentResult = @task_comment.lumniSave(params,current_user)
		lumniClose(@task_comment,taskCommentResult)
	end

	def update
		@task_comment = ProjectComment.lumniStart(params,current_company)
		taskCommentResult = @task_comment.lumniSave(params,current_user)
		lumniClose(@task_comment,taskCommentResult)
	end
	def destroy
		@task_comment = ProjectComment.lumniStart(params,current_company)
		taskCommentResult = @task_comment.lumniSave(params,current_user)
		lumniClose(@task_comment,taskCommentResult)
		@result =taskCommentResult
	end

	def show_chat
	end
end
