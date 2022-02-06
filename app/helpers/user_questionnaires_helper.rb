module UserQuestionnairesHelper
	def create_questionnaire_list user_id
		@user_id = user_id
		@user_questionnaires = UserQuestionnaire.includes(:questionnaire).joins(origination_section: [origination_module: :origination]).where('originations.discarded_at IS NULL AND origination_modules.discarded_at IS NULL AND origination_sections.discarded_at IS NULL').distinct.kept.where(user_id: user_id)

		col_names = ['id','name','status','main_score','final_result','time','start_time','end_time','actions']

		@headers = col_names.map{|q| UserQuestionnaire.human_attribute_name(q)}
		@rows_info =[] 
		@user_questionnaires.each do |q| 
			@rows_info += [col_names.map{|c| translate_user_questionnaire q, c }]
		end
		render 'user_questionnaires/partial/questionnaire_list'
	end

	def translate_user_questionnaire questionnaire, field
		case field
		when 'id'
			case questionnaire.questionnaire.category
			when 'review', 'interview'
				result = link_to questionnaire.send(field), start_test_user_questionnaire_path(questionnaire), class: 'text-primary', target: :blank
			else
				result = questionnaire.send(field)
			end
		when 'name'
			result = create_questionnaire_link_element(questionnaire.id)
		when 'status'
			result = I18n.t("list.#{field}")
		when 'actions'
			result = render 'user_questionnaires/partial/manage_actions', questionnaire: questionnaire
		when 'main_score'
			result = questionnaire.send(field).to_f.round(1)
		else
			result = questionnaire.send(field)
		end
		return result

	end

	def create_questionnaire_link_element user_questionnaire_id
		element = UserQuestionnaire.cached_find(user_questionnaire_id)
		if element.status == 'finished'
			render 'user_questionnaires/partial/link_element', element: element 
		else
			element.questionnaire.name
		end

	end

	def create_user_questionnaire_result user_questionnaire_id
		@target_user_questionnaire = UserQuestionnaire.cached_find(user_questionnaire_id)
		render 'user_questionnaires/partial/result_body'

	end

	def create_accordion_result user_questionnaire_id,questionnaire_id
		@user_questionnaire = UserQuestionnaire.cached_find(user_questionnaire_id)
		@questionnaire = Questionnaire.cached_find(questionnaire_id)
		render 'user_questionnaires/partial/list_accordion_results'
	end

	def define_score_color questionnaire_id, user_questionnaire_id
		puts "user_questionnaire_id: #{user_questionnaire_id}"
		puts "questionnaire_id: #{questionnaire_id}"
		questionnaire = Questionnaire.cached_find(questionnaire_id)
		score = questionnaire.total_score user_questionnaire_id
		min_score = questionnaire.min_approval_score.to_f
		target_text = 'danger'

		if score >= [80,min_score].max
			target_text = 'success'
		elsif score < [80,min_score].max && score >= min_score
			target_text = 'warning'
		end
		return target_text
	end
end


