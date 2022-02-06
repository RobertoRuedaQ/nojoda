class FeedbacksController < ApplicationController
	def index
		@feedback = Feedback.lumniStart(params,current_company, list: current_user.template('Feedback','feedbacks',current_user))
		contactFeedback = @feedback.lumniSave(params,current_user, list: current_user.template('Feedback','feedbacks',current_user))
		lumniClose(@feedback,contactFeedback)
	end

	def new
		@feedback = Feedback.lumniStart(params,current_company, list: current_user.template('Feedback','feedbacks',current_user))
		@feedback.controller = params[:target_controller] if !params[:target_controller].nil?
		@feedback.action = params[:target_action] if !params[:target_action].nil?
		@feedback.feedback_id = params[:feedbackid] if !params[:feedbackid].nil?
		@feedback.autor_id = current_user.id
		@feedback.status = 'pending'
		contactFeedback = @feedback.lumniSave(params,current_user, list: current_user.template('Feedback','feedbacks',current_user))
		lumniClose(@feedback,contactFeedback)
	end

	def create
		@feedback = Feedback.lumniStart(params,current_company, list: current_user.template('Feedback','feedbacks',current_user))
		contactFeedback = @feedback.lumniSave(params,current_user, list: current_user.template('Feedback','feedbacks',current_user))
		lumniClose(@feedback,contactFeedback)
	end

	def edit
		@feedback = Feedback.lumniStart(params,current_company, list: current_user.template('Feedback','feedbacks',current_user))
		contactFeedback = @feedback.lumniSave(params,current_user, list: current_user.template('Feedback','feedbacks',current_user))
		lumniClose(@feedback,contactFeedback)
	end

	def update
		@feedback = Feedback.lumniStart(params,current_company, list: current_user.template('Feedback','feedbacks',current_user))
		contactFeedback = @feedback.lumniSave(params,current_user, list: current_user.template('Feedback','feedbacks',current_user))
		lumniClose(@feedback,contactFeedback)
	end
	def destroy
		@feedback = Feedback.lumniStart(params,current_company, list: current_user.template('Feedback','feedbacks',current_user))
		contactFeedback = @feedback.lumniSave(params,current_user, list: current_user.template('Feedback','feedbacks',current_user))
		lumniClose(@cluster,contactFeedback)
	end

end