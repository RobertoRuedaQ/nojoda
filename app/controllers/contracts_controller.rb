class ContractsController < ApplicationController
	def index
		@contract = Contract.lumniStart(params,current_company, list: current_user.template('Contract','contracts',current_user))
		contactContract = @contract.lumniSave(params,current_user, list: current_user.template('Contract','contracts',current_user))
		lumniClose(@contract,contactContract)
	end

	def new
		@contract = Contract.lumniStart(params,current_company, list: current_user.template('Contract','contracts',current_user))
		contactContract = @contract.lumniSave(params,current_user, list: current_user.template('Contract','contracts',current_user))
		lumniClose(@contract,contactContract)
	end

	def create
		@contract = Contract.lumniStart(params,current_company, list: current_user.template('Contract','contracts',current_user))
		contactContract = @contract.lumniSave(params,current_user, list: current_user.template('Contract','contracts',current_user))
		lumniClose(@contract,contactContract)
	end

	def edit
		@contract = Contract.lumniStart(params,current_company, list: current_user.template('Contract','contracts',current_user))
		contactContract = @contract.lumniSave(params,current_user, list: current_user.template('Contract','contracts',current_user))
		lumniClose(@contract,contactContract)
	end

	def update
		@contract = Contract.lumniStart(params,current_company, list: current_user.template('Contract','contracts',current_user))
		contactContract = @contract.lumniSave(params,current_user, list: current_user.template('Contract','contracts',current_user))
		lumniClose(@contract,contactContract)
	end
	def destroy
		@contract = Contract.lumniStart(params,current_company, list: current_user.template('Contract','contracts',current_user))
		contactContract = @contract.lumniSave(params,current_user, list: current_user.template('Contract','contracts',current_user))
		lumniClose(@cluster,contactContract)
	end
end