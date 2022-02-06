class MultipleChoicesController < ApplicationController
	def index
		@multiple_choice = MultipleChoice.lumniStart(params,current_company, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		contactMultipleChoice = @multiple_choice.lumniSave(params,current_user, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		lumniClose(@multiple_choice,contactMultipleChoice)
	end

	def new
		@multiple_choice = MultipleChoice.lumniStart(params,current_company, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		contactMultipleChoice = @multiple_choice.lumniSave(params,current_user, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		lumniClose(@multiple_choice,contactMultipleChoice)
	end

	def create
		@multiple_choice = MultipleChoice.lumniStart(params,current_company, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		contactMultipleChoice = @multiple_choice.lumniSave(params,current_user, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		lumniClose(@multiple_choice,contactMultipleChoice)
	end

	def edit
		@multiple_choice = MultipleChoice.lumniStart(params,current_company, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		contactMultipleChoice = @multiple_choice.lumniSave(params,current_user, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		lumniClose(@multiple_choice,contactMultipleChoice)
	end

	def update
		@multiple_choice = MultipleChoice.lumniStart(params,current_company, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		contactMultipleChoice = @multiple_choice.lumniSave(params,current_user, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		lumniClose(@multiple_choice,contactMultipleChoice)
	end
	def destroy
		@multiple_choice = MultipleChoice.lumniStart(params,current_company, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		contactMultipleChoice = @multiple_choice.lumniSave(params,current_user, list: current_user.template('MultipleChoice','multiple_choices',current_user))
		lumniClose(@cluster,contactMultipleChoice)
	end
end