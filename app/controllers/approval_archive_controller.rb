class ApprovalArchiveController < ApplicationController
	def index
		@approval = Approval::Request.where(supervisor_id: current_user.id).or(Approval::Request.where(request_user_id: current_user.id)).where.not(state: 'pending').kept
	end

	def edit
		@approval = Approval::Request.lumniStart(params,current_company)
		approvalResult = @approval.lumniSave(params,current_user)
		lumniClose(@approval,approvalResult)
	end


end
