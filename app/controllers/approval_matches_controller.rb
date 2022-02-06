class ApprovalMatchesController < ApplicationController
	def index
		@approval_match = ApprovalMatch.lumniStart(params,current_company)
		approvalMatchResult = @approval_match.lumniSave(params,current_user)
		lumniClose(@approval_match,approvalMatchResult)
	end

	def new
		@approval_match = ApprovalMatch.lumniStart(params,current_company)
		approvalMatchResult = @approval_match.lumniSave(params,current_user)
		lumniClose(@approval_match,approvalMatchResult)
	end

	def create
		@approval_match = ApprovalMatch.lumniStart(params,current_company)
		approvalMatchResult = @approval_match.lumniSave(params,current_user)
		lumniClose(@approval_match,approvalMatchResult)
	end

	def edit
		@approval_match = ApprovalMatch.lumniStart(params,current_company)
		approvalMatchResult = @approval_match.lumniSave(params,current_user)
		lumniClose(@approval_match,approvalMatchResult)
	end

	def update
		@approval_match = ApprovalMatch.lumniStart(params,current_company)
		approvalMatchResult = @approval_match.lumniSave(params,current_user)
		lumniClose(@approval_match,approvalMatchResult)
	end
	def destroy
		@approval_match = ApprovalMatch.lumniStart(params,current_company)
		approvalMatchResult = @approval_match.lumniSave(params,current_user)
		lumniClose(@approval_match,approvalMatchResult)
	end

end
