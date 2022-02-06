class UserQuestionnaireAnswersController < ApplicationController
	def index
		@user_questionnaire_answer = UserQuestionnaireAnswer.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		contactUserQuestionnaireAnswer = @user_questionnaire_answer.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		lumniClose(@user_questionnaire_answer,contactUserQuestionnaireAnswer)
	end

	def new
		@user_questionnaire_answer = UserQuestionnaireAnswer.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		contactUserQuestionnaireAnswer = @user_questionnaire_answer.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		lumniClose(@user_questionnaire_answer,contactUserQuestionnaireAnswer)
	end

	def create
		@user_questionnaire_answer = UserQuestionnaireAnswer.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		contactUserQuestionnaireAnswer = @user_questionnaire_answer.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		lumniClose(@user_questionnaire_answer,contactUserQuestionnaireAnswer)
	end

	def edit
		@user_questionnaire_answer = UserQuestionnaireAnswer.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		contactUserQuestionnaireAnswer = @user_questionnaire_answer.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		lumniClose(@user_questionnaire_answer,contactUserQuestionnaireAnswer)
	end

	def update
		@user_questionnaire_answer = UserQuestionnaireAnswer.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		contactUserQuestionnaireAnswer = @user_questionnaire_answer.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		lumniClose(@user_questionnaire_answer,contactUserQuestionnaireAnswer)
	end
	def destroy
		@user_questionnaire_answer = UserQuestionnaireAnswer.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		contactUserQuestionnaireAnswer = @user_questionnaire_answer.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireAnswer','user_questionnaire_answers',current_user))
		lumniClose(@cluster,contactUserQuestionnaireAnswer)
	end
	def save_answers
		@user_questionnaire = UserQuestionnaire.includes(:user_questionnaire_answer,{questionnaire: [all_questions: :answer]}).find(params[:id])
		answers_ids = params[:answer].values
		notes = params[:notes].nil? ? nil : params[:notes].values
		questions =  @user_questionnaire.questionnaire.all_questions.joins(:answer).where(answers: {id: answers_ids})

		answers = Answer.where(id: answers_ids)

		answers_ids.each_with_index do |answer_id,index|
			note = notes.nil? ? nil : notes[index]
			answer = answers.select{|a| a.id == answer_id.to_i}.first
			user_answer = @user_questionnaire.user_questionnaire_answer.joins(:answer).find_by(answers: {question_id: answer.question_id})
			if user_answer.present?
				user_answer.update({answer_id: answer_id,user_questionnaire_id: params[:id],notes: note})
			else
				UserQuestionnaireAnswer.create({answer_id: answer_id,user_questionnaire_id: params[:id],notes: note})
			end
		end

		if valid_questionnaire?
			@user_questionnaire.update_columns(status: "finished")
			redirect_to finish_test_user_questionnaire_path(params[:id])
		else
			redirect_to test_taker_user_questionnaire_path(params[:id])
		end
	end


	private

	def valid_questionnaire?
		review? || (all_questions? && right_type_of_questionnaire?)
	end


	def review?
		params[:review].present? && params[:review][:score].to_s == 'true'
	end

	def all_questions?
		@user_questionnaire.all_questions.size == @user_questionnaire.user_questionnaire_answer.count
	end

	def right_type_of_questionnaire?
		@user_questionnaire.questionnaire.category == 'selection_test' || @user_questionnaire.questionnaire.category == 'interview'
	end
end