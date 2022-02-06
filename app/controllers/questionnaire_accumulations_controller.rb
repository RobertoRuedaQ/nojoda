class QuestionnaireAccumulationsController < ApplicationController
	def index
		@questionnaire_accumulation = QuestionnaireAccumulation.lumniStart(params,current_company, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		contactQuestionnaireAccumulation = @questionnaire_accumulation.lumniSave(params,current_user, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		lumniClose(@questionnaire_accumulation,contactQuestionnaireAccumulation)
	end

	def new
		@questionnaire_accumulation = QuestionnaireAccumulation.lumniStart(params,current_company, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		contactQuestionnaireAccumulation = @questionnaire_accumulation.lumniSave(params,current_user, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		lumniClose(@questionnaire_accumulation,contactQuestionnaireAccumulation)
	end

	def create
		@questionnaire_accumulation = QuestionnaireAccumulation.lumniStart(params,current_company, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		contactQuestionnaireAccumulation = @questionnaire_accumulation.lumniSave(params,current_user, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		lumniClose(@questionnaire_accumulation,contactQuestionnaireAccumulation)
	end

	def edit
		@questionnaire_accumulation = QuestionnaireAccumulation.lumniStart(params,current_company, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		contactQuestionnaireAccumulation = @questionnaire_accumulation.lumniSave(params,current_user, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		lumniClose(@questionnaire_accumulation,contactQuestionnaireAccumulation)
	end

	def update
		@questionnaire_accumulation = QuestionnaireAccumulation.lumniStart(params,current_company, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		contactQuestionnaireAccumulation = @questionnaire_accumulation.lumniSave(params,current_user, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		lumniClose(@questionnaire_accumulation,contactQuestionnaireAccumulation)
	end
	def destroy
		@questionnaire_accumulation = QuestionnaireAccumulation.lumniStart(params,current_company, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		contactQuestionnaireAccumulation = @questionnaire_accumulation.lumniSave(params,current_user, list: current_user.template('QuestionnaireAccumulation','questionnaire_accumulations',current_user))
		lumniClose(@cluster,contactQuestionnaireAccumulation)
	end
end