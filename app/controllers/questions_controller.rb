class QuestionsController < ApplicationController
	def index
		@question = Question.lumniStart(params,current_company, list: current_user.template('Question','questions',current_user))
		questionResult = @question.lumniSave(params,current_user, list: current_user.template('Question','questions',current_user))
		lumniClose(@question,questionResult)
	end

	def new
		@question = Question.lumniStart(params,current_company, list: current_user.template('Question','questions',current_user))
		questionResult = @question.lumniSave(params,current_user, list: current_user.template('Question','questions',current_user))
		lumniClose(@question,questionResult)
	end

	def create
		@question = Question.lumniStart(params,current_company, list: current_user.template('Question','questions',current_user))
		questionResult = @question.lumniSave(params,current_user, list: current_user.template('Question','questions',current_user))
		lumniClose(@question,questionResult)
	end

	def edit
		@question = Question.lumniStart(params,current_company, list: current_user.template('Question','questions',current_user))
		questionResult = @question.lumniSave(params,current_user, list: current_user.template('Question','questions',current_user))
		lumniClose(@question,questionResult)
	end

	def update
		@question = Question.lumniStart(params,current_company, list: current_user.template('Question','questions',current_user))
		questionResult = @question.lumniSave(params,current_user, list: current_user.template('Question','questions',current_user))
		lumniClose(@question,questionResult)
	end
	def destroy
		@question = Question.lumniStart(params,current_company, list: current_user.template('Question','questions',current_user))
		questionResult = @question.lumniSave(params,current_user, list: current_user.template('Question','questions',current_user))
		lumniClose(@question,questionResult)
		@result =questionResult
	end

	def new_question

		@section = Questionnaire.cached_find(params[:id])
		newPosition = @section.question.count + 1
		@question = Question.new({questionnaire_id: @section.id,position: newPosition})
	end

	def edit_question
		@question = Question.cached_find(params[:id])
	end
end
