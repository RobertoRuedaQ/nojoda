class CommunicationCasesController < ApplicationController
	def index
		@communication_case = CommunicationCase.lumniStart(params,current_company)
		communicationCaseResult = @communication_case.lumniSave(params,current_user)
		lumniClose(@communication_case,communicationCaseResult)
	end

	def new
		@communication_case = CommunicationCase.lumniStart(params,current_company)
		@communication_case.company = current_company
		communicationCaseResult = @communication_case.lumniSave(params,current_user)
		lumniClose(@communication_case,communicationCaseResult)
	end

	def create
		@communication_case = CommunicationCase.lumniStart(params,current_company)
		communicationCaseResult = @communication_case.lumniSave(params,current_user)
		lumniClose(@communication_case,communicationCaseResult)
	end

	def edit
		@communication_case = CommunicationCase.lumniStart(params,current_company)
		communicationCaseResult = @communication_case.lumniSave(params,current_user)
		lumniClose(@communication_case,communicationCaseResult)
	end

	def update
		@communication_case = CommunicationCase.lumniStart(params,current_company)
		communicationCaseResult = @communication_case.lumniSave(params,current_user)
		lumniClose(@communication_case,communicationCaseResult)
	end
	def destroy
		@communication_case = CommunicationCase.lumniStart(params,current_company)
		communicationCaseResult = @communication_case.lumniSave(params,current_user)
		lumniClose(@cluster,communicationCaseResult)
	end
end
