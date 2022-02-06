class AnswersController < ApplicationController
	def index
		@answer = Answer.lumniStart(params,current_company)
		answerResult = @answer.lumniSave(params,current_user)
		lumniClose(@answer,answerResult)
	end

	def new
		@answer = Answer.lumniStart(params,current_company)
		answerResult = @answer.lumniSave(params,current_user)
		lumniClose(@answer,answerResult)
	end

	def create
		@answer = Answer.lumniStart(params,current_company)
		answerResult = @answer.lumniSave(params,current_user)
		lumniClose(@answer,answerResult)
	end

	def edit
		@answer = Answer.lumniStart(params,current_company)
		answerResult = @answer.lumniSave(params,current_user)
		lumniClose(@answer,answerResult)
	end

	def update
		@answer = Answer.lumniStart(params,current_company)
		answerResult = @answer.lumniSave(params,current_user)
		lumniClose(@answer,answerResult)
	end
	def destroy
		@answer = Answer.lumniStart(params,current_company)
		answerResult = @answer.lumniSave(params,current_user)
		lumniClose(@answer,answerResult)
	end

	def sort
		Answer.update(params[:sort],(1..params[:sort].length).map{ |o |{position: o} })
	end

	def new_answer
		@question = Question.cached_find(params[:id])
		newPosition = @question.answer.count + 1
		@answer = Answer.new({question_id: @question.id,position: newPosition})
	end

	def edit_answer
		@answer = Answer.cached_find(params[:id])
	end
end
