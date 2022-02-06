class QuestionnaireExceptionsController < ApplicationController
	def index
		@questionnaire_exception = QuestionnaireException.lumniStart(params,current_company, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		contactQuestionnaireException = @questionnaire_exception.lumniSave(params,current_user, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		lumniClose(@questionnaire_exception,contactQuestionnaireException)
	end

	def new
		@questionnaire_exception = QuestionnaireException.lumniStart(params,current_company, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		@questionnaire_exception.user_questionnaire_id = params[:questionnaire]
		contactQuestionnaireException = @questionnaire_exception.lumniSave(params,current_user, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		lumniClose(@questionnaire_exception,contactQuestionnaireException)
	end

	def create
		@questionnaire_exception = QuestionnaireException.lumniStart(params,current_company, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		contactQuestionnaireException = @questionnaire_exception.lumniSave(params,current_user, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		@questionnaire_exception.user_questionnaire.update(status: 'finished')
		if !params[:target_controller].nil? && !params[:target_user].nil?
			redirect_to eval("edit_#{params[:target_controller].singularize}_path(#{params[:target_user]})")
		else
			lumniClose(@questionnaire_exception,contactQuestionnaireException)
		end
	end

	def edit
		@questionnaire_exception = QuestionnaireException.lumniStart(params,current_company, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		contactQuestionnaireException = @questionnaire_exception.lumniSave(params,current_user, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		lumniClose(@questionnaire_exception,contactQuestionnaireException)
	end

	def update
		@questionnaire_exception = QuestionnaireException.lumniStart(params,current_company, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		contactQuestionnaireException = @questionnaire_exception.lumniSave(params,current_user, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		lumniClose(@questionnaire_exception,contactQuestionnaireException)
	end
	def destroy
		@questionnaire_exception = QuestionnaireException.lumniStart(params,current_company, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		contactQuestionnaireException = @questionnaire_exception.lumniSave(params,current_user, list: current_user.template('QuestionnaireException','questionnaire_exceptions',current_user))
		lumniClose(@cluster,contactQuestionnaireException)
	end
end