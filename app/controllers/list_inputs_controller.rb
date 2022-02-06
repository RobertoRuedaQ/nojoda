class ListInputsController < ApplicationController
	def index
		@list_input = ListInput.lumniStart(params,current_company, list: current_user.template('ListInput','list_inputs',current_user))
		contactListInput = @list_input.lumniSave(params,current_user, list: current_user.template('ListInput','list_inputs',current_user))
		lumniClose(@list_input,contactListInput)
	end

	def new
		@list_input = ListInput.lumniStart(params,current_company, list: current_user.template('ListInput','list_inputs',current_user))
		contactListInput = @list_input.lumniSave(params,current_user, list: current_user.template('ListInput','list_inputs',current_user))
		lumniClose(@list_input,contactListInput)
	end

	def create
		@list_input = ListInput.lumniStart(params,current_company, list: current_user.template('ListInput','list_inputs',current_user))
		contactListInput = @list_input.lumniSave(params,current_user, list: current_user.template('ListInput','list_inputs',current_user))
		lumniClose(@list_input,contactListInput)
	end

	def edit
		@list_input = ListInput.lumniStart(params,current_company, list: current_user.template('ListInput','list_inputs',current_user))
		contactListInput = @list_input.lumniSave(params,current_user, list: current_user.template('ListInput','list_inputs',current_user))
		lumniClose(@list_input,contactListInput)
	end

	def update
		@list_input = ListInput.lumniStart(params,current_company, list: current_user.template('ListInput','list_inputs',current_user))
		contactListInput = @list_input.lumniSave(params,current_user, list: current_user.template('ListInput','list_inputs',current_user))
		lumniClose(@list_input,contactListInput)
	end
	def destroy
		@list_input = ListInput.lumniStart(params,current_company, list: current_user.template('ListInput','list_inputs',current_user))
		contactListInput = @list_input.lumniSave(params,current_user, list: current_user.template('ListInput','list_inputs',current_user))
		lumniClose(@cluster,contactListInput)
	end
end