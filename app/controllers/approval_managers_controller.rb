class ApprovalManagersController < ApplicationController
	def index
		@approval = Approval::Request.where(supervisor_id: current_user.id).or(Approval::Request.where(request_user_id: current_user.id)).where(state: 'pending').kept
	end

	def edit
		@approval = Approval::Request.lumniStart(params,current_company)
		approvalResult = @approval.lumniSave(params,current_user)
		lumniClose(@approval,approvalResult)
	end

	def update
		@approval = Approval::Request.lumniStart(params,current_company)
		approvalResult = @approval.lumniSave(params,current_user)
		lumniClose(@approval,approvalResult)
	end

	def approve
		request = Approval::Request.find(params[:id])
		response = current_user.approve_request(request,reason: 'just because')
		if response.save!
			flash[:success] = I18n.t('flash.record_approved')
		else
			flash[:danger] = I18n.t('flash.record_failed')
		end
		redirect_to "/approval_managers/#{params[:id]}/edit"
	end
	def reject
		request = Approval::Request.find(params[:id])
		response = current_user.reject_request(request,reason: 'just because')
		if response.save!
			flash[:success] = I18n.t('flash.record_rejected')
		else
			flash[:danger] = I18n.t('flash.record_failed')
		end
		redirect_to "/approval_managers/#{params[:id]}/edit"
	end
	def cancel
		request = Approval::Request.find(params[:id])
		response = current_user.cancel_request(request,reason: 'just because')
		if response.save!
			flash[:success] = I18n.t('flash.record_canceled')
		else
			flash[:danger] = I18n.t('flash.record_failed')
		end
		redirect_to "/approval_managers/#{params[:id]}/edit"
	end

	def reasign
		request = Approval::Request.find(params[:id])
		request.supervisor_id = params[:approval][:approver]		
		if request.save!
			flash[:success] = I18n.t('flash.record_reasigned')
		else
			flash[:danger] = I18n.t('flash.record_failed')
		end
		redirect_to "/approval_managers/"
	end

end
