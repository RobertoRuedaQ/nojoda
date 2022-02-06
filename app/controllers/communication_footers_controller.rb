class CommunicationFootersController < ApplicationController
	def index
		@communication_footer = CommunicationFooter.lumniStart(params,current_company)
		communicationFooterResult = @communication_footer.lumniSave(params,current_user)
		lumniClose(@communication_footer,communicationFooterResult)
	end

	def new
		@communication_footer = CommunicationFooter.lumniStart(params,current_company)
		@communication_footer.company = current_company
		communicationFooterResult = @communication_footer.lumniSave(params,current_user)
		lumniClose(@communication_footer,communicationFooterResult)
	end

	def create
		@communication_footer = CommunicationFooter.lumniStart(params,current_company)
		communicationFooterResult = @communication_footer.lumniSave(params,current_user)
		lumniClose(@communication_footer,communicationFooterResult)
	end

	def edit
		@communication_footer = CommunicationFooter.lumniStart(params,current_company)
		communicationFooterResult = @communication_footer.lumniSave(params,current_user)
		lumniClose(@communication_footer,communicationFooterResult)
	end

	def update
		@communication_footer = CommunicationFooter.lumniStart(params,current_company)
		communicationFooterResult = @communication_footer.lumniSave(params,current_user)
		lumniClose(@communication_footer,communicationFooterResult)
	end
	def destroy
		@communication_footer = CommunicationFooter.lumniStart(params,current_company)
		communicationFooterResult = @communication_footer.lumniSave(params,current_user)
		lumniClose(@cluster,communicationFooterResult)
	end
end
