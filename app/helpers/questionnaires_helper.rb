module QuestionnairesHelper
	def createQuestionnaireSection(target_section_id)
		@targetSection = Questionnaire.cached_find(target_section_id)
		render '/questionnaires/partials/section'
	end

	def headerSectionQuestionnaire(targetSectionId)
		@targetSection = Questionnaire.cached_find(targetSectionId)
		render '/questionnaires/partials/header_section'
	end
	def questionsSectionQuestionnaire(targetQuestion)
		@targetQuestion = targetQuestion
		render '/questionnaires/partials/question'
	end

	def createAnswerQuestionnaire(targetAnswerId)
		@targetAnswer = Answer.cached_find(targetAnswerId)
		render '/questionnaires/partials/answer'
	end

	def createQuestionHeaderQuestionnaire(targetQuestion)
		@targetQuestion = targetQuestion
		render '/questionnaires/partials/header_question'
	end

	def headerAnswerQuestionnaire(targetAnswerId)
		@targetAnswer = Answer.cached_find(targetAnswerId)
		render '/questionnaires/partials/header_answer'
	end

	def createSectionBodyQuestionnaire(targetSectionId)
		@targetSection = Questionnaire.cached_find(targetSectionId)
		render '/questionnaires/partials/section_body'
	end

	def create_partial_questionnaire_view user_questionnaire_id
		@user_questionnaire = UserQuestionnaire.cached_find(user_questionnaire_id)
		render 'user_questionnaires/partial/pending_questionnaire'
	end

	def translate_questionnaire_text user_questionnaire
		target_text = user_questionnaire.questionnaire.instructions.to_s
		target_text.gsub! '##number_questions', user_questionnaire.all_questions.count.to_s
		target_text.gsub! '##time_minutes', user_questionnaire.questionnaire.time_limit.to_s

		team = application_team(user_questionnaire)
		if team.any?
			supervisor = team.first.user

			target_text.gsub! '##supervisor_name', (supervisor.name || '')
			target_text.gsub! '##supervisor_phone', (supervisor.contact_info.phone || '')
			target_text.gsub! '##supervisor_mobile', (supervisor.contact_info.mobile || '')
			target_text.gsub! '##supervisor_email', (supervisor.email || '')
		end
		
		return target_text
	end

	def application_team(user_questionnaire)
		user_questionnaire.application.funding_opportunity.funding_opportunity_team
	end
	
end
