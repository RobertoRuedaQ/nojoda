class UserQuestionnaireScoresController < ApplicationController
	def index
		@user_questionnaire_score = UserQuestionnaireScore.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		contactUserQuestionnaireScore = @user_questionnaire_score.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		lumniClose(@user_questionnaire_score,contactUserQuestionnaireScore)
	end

	def new
		@user_questionnaire_score = UserQuestionnaireScore.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		contactUserQuestionnaireScore = @user_questionnaire_score.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		lumniClose(@user_questionnaire_score,contactUserQuestionnaireScore)
	end

	def create
		@user_questionnaire_score = UserQuestionnaireScore.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		contactUserQuestionnaireScore = @user_questionnaire_score.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		lumniClose(@user_questionnaire_score,contactUserQuestionnaireScore)
	end

	def edit
		@user_questionnaire_score = UserQuestionnaireScore.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		contactUserQuestionnaireScore = @user_questionnaire_score.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		lumniClose(@user_questionnaire_score,contactUserQuestionnaireScore)
	end

	def update
		@user_questionnaire_score = UserQuestionnaireScore.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		contactUserQuestionnaireScore = @user_questionnaire_score.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		lumniClose(@user_questionnaire_score,contactUserQuestionnaireScore)
	end
	def destroy
		@user_questionnaire_score = UserQuestionnaireScore.lumniStart(params,current_company, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		contactUserQuestionnaireScore = @user_questionnaire_score.lumniSave(params,current_user, list: current_user.template('UserQuestionnaireScore','user_questionnaire_scores',current_user))
		lumniClose(@cluster,contactUserQuestionnaireScore)
	end
end