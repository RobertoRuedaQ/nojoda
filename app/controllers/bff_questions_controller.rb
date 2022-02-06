class BffQuestionsController < ApplicationController
	def index
		@bff_question = BffQuestion.lumniStart(params,current_company, list: current_user.template('BffQuestion','bff_questions',current_user))
		contactBffQuestion = @bff_question.lumniSave(params,current_user, list: current_user.template('BffQuestion','bff_questions',current_user))
		lumniClose(@bff_question,contactBffQuestion)
	end

	def new
		@bff_question = BffQuestion.lumniStart(params,current_company, list: current_user.template('BffQuestion','bff_questions',current_user))
		contactBffQuestion = @bff_question.lumniSave(params,current_user, list: current_user.template('BffQuestion','bff_questions',current_user))
		lumniClose(@bff_question,contactBffQuestion)
	end

	def create
		@bff_question = BffQuestion.lumniStart(params,current_company, list: current_user.template('BffQuestion','bff_questions',current_user))
		contactBffQuestion = @bff_question.lumniSave(params,current_user, list: current_user.template('BffQuestion','bff_questions',current_user))
		lumniClose(@bff_question,contactBffQuestion)
	end

	def edit
		@bff_question = BffQuestion.lumniStart(params,current_company, list: current_user.template('BffQuestion','bff_questions',current_user))
		contactBffQuestion = @bff_question.lumniSave(params,current_user, list: current_user.template('BffQuestion','bff_questions',current_user))
		lumniClose(@bff_question,contactBffQuestion)
	end

	def update
		@bff_question = BffQuestion.lumniStart(params,current_company, list: current_user.template('BffQuestion','bff_questions',current_user))
		contactBffQuestion = @bff_question.lumniSave(params,current_user, list: current_user.template('BffQuestion','bff_questions',current_user))
		lumniClose(@bff_question,contactBffQuestion)
	end
	def destroy
		@bff_question = BffQuestion.lumniStart(params,current_company, list: current_user.template('BffQuestion','bff_questions',current_user))
		contactBffQuestion = @bff_question.lumniSave(params,current_user, list: current_user.template('BffQuestion','bff_questions',current_user))
		lumniClose(@cluster,contactBffQuestion)
	end
end