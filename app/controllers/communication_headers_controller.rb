class CommunicationHeadersController < ApplicationController
	def index
		@communication_header = CommunicationHeader.lumniStart(params,current_company)
		communicationHeaderResult = @communication_header.lumniSave(params,current_user)
		lumniClose(@communication_header,communicationHeaderResult)
	end

	def new
		@communication_header = CommunicationHeader.lumniStart(params,current_company)
		@communication_header.company = current_company
		communicationHeaderResult = @communication_header.lumniSave(params,current_user)
		lumniClose(@communication_header,communicationHeaderResult)
	end

	def create
		@communication_header = CommunicationHeader.lumniStart(params,current_company)
		communicationHeaderResult = @communication_header.lumniSave(params,current_user)
		lumniClose(@communication_header,communicationHeaderResult)
	end

	def edit
		@communication_header = CommunicationHeader.lumniStart(params,current_company)
		communicationHeaderResult = @communication_header.lumniSave(params,current_user)
		lumniClose(@communication_header,communicationHeaderResult)
	end

	def update
		@communication_header = CommunicationHeader.lumniStart(params,current_company)
		communicationHeaderResult = @communication_header.lumniSave(params,current_user)
		lumniClose(@communication_header,communicationHeaderResult)
	end
	def destroy
		@communication_header = CommunicationHeader.lumniStart(params,current_company)
		communicationHeaderResult = @communication_header.lumniSave(params,current_user)
		lumniClose(@cluster,communicationHeaderResult)
	end
end
