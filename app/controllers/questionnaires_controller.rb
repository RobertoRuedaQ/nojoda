class QuestionnairesController < ApplicationController	
	include LumniMigration
	
	def index
		@questionnaire = Questionnaire.lumniStart(params,current_company,list: current_user.template('Questionnaire','questionnaires',current_user)).main.where(company_id: current_company.id)
		questionnaireResult = @questionnaire.lumniSave(params,current_user,list: current_user.template('Questionnaire','questionnaires',current_user))
		lumniClose(@questionnaire,questionnaireResult)
	end

	def new
		@questionnaire = Questionnaire.lumniStart(params,current_company,list: current_user.template('Questionnaire','questionnaires',current_user))
		@questionnaire.company_id = current_company.id
		questionnaireResult = @questionnaire.lumniSave(params,current_user,list: current_user.template('Questionnaire','questionnaires',current_user))
		lumniClose(@questionnaire,questionnaireResult)
	end

	def create
		@questionnaire = Questionnaire.lumniStart(params,current_company,list: current_user.template('Questionnaire','questionnaires',current_user))
		questionnaireResult = @questionnaire.lumniSave(params,current_user,list: current_user.template('Questionnaire','questionnaires',current_user))
		lumniClose(@questionnaire,questionnaireResult)
	end

	def edit
		@questionnaire = Questionnaire.cached_questionnaire(params[:id])
		if @questionnaire.company_id == current_company.id
			questionnaireResult = @questionnaire.lumniSave(params,current_user,list: current_user.template('Questionnaire','questionnaires',current_user))
		else
			questionnaireResult = 'unauthorized'
		end
		lumniClose(@questionnaire,questionnaireResult)
	end

	def update
		@questionnaire = Questionnaire.lumniStart(params,current_company,list: current_user.template('Questionnaire','questionnaires',current_user))
		questionnaireResult = @questionnaire.lumniSave(params,current_user,list: current_user.template('Questionnaire','questionnaires',current_user))
		lumniClose(@questionnaire,questionnaireResult)
	end

	def destroy
		@questionnaire = Questionnaire.lumniStart(params,current_company,list: current_user.template('Questionnaire','questionnaires',current_user))
		questionnaireResult = @questionnaire.lumniSave(params,current_user,list: current_user.template('Questionnaire','questionnaires',current_user))
		lumniClose(@questionnaire,questionnaireResult)
	end

	def sort
		eval(params[:model]).update(params[:sort],(1..params[:sort].length).map{ |o |{position: o} })
	end

	def new_section
		params[:action] = 'edit'
		@questionnaire = Questionnaire.lumniStart(params,current_company,list: current_user.template('Questionnaire','questionnaires',current_user))
		questionnaireResult = @questionnaire.lumniSave(params,current_user,list: current_user.template('Questionnaire','questionnaires',current_user))
		lumniClose(@questionnaire,questionnaireResult)
	end

	def edit_section
		params[:action] = 'edit'
		@questionnaire = Questionnaire.lumniStart(params,current_company,list: current_user.template('Questionnaire','questionnaires',current_user))
		questionnaireResult = @questionnaire.lumniSave(params,current_user,list: current_user.template('Questionnaire','questionnaires',current_user))
		lumniClose(@questionnaire,questionnaireResult)
	end

	def body_section
		params[:action] = 'edit'
		@questionnaire = Questionnaire.lumniStart(params,current_company,list: current_user.template('Questionnaire','questionnaires',current_user))
		questionnaireResult = @questionnaire.lumniSave(params,current_user,list: current_user.template('Questionnaire','questionnaires',current_user))
		lumniClose(@questionnaire,questionnaireResult)
	end

	def migrate
#		migrate_selection_test
		MigrationAsync.perform_async('migrate_selection_test')
		respond_to do |format|
			format.js
		end
	end

	def clone
		@questionnaire = Questionnaire.cached_find(params[:id])
	end

	def create_clone
		original_questionnaire = Questionnaire.cached_find(params[:id])

		params[:action] = 'create'
		@questionnaire = Questionnaire.lumniStart(params,current_company,list: current_user.template('Questionnaire','questionnaires',current_user))
		questionnaireResult = @questionnaire.lumniSave(params,current_user,list: current_user.template('Questionnaire','questionnaires',current_user))

		if !@questionnaire.id.nil?
			target_questionnaire = @questionnaire

			original_questionnaire.childs
		end

		lumniClose(@questionnaire,questionnaireResult)
	end

	def clone_childs target_questionnaire
		target_questionnaire.childs.each do |questionnaire|
		end
	end


end
