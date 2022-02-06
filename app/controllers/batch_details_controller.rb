class BatchDetailsController < ApplicationController
	def index
		@batch_detail = BatchDetail.lumniStart(params,current_company, list: current_user.template('BatchDetail','batch_details',current_user))
		contactBatchDetail = @batch_detail.lumniSave(params,current_user, list: current_user.template('BatchDetail','batch_details',current_user))
		lumniClose(@batch_detail,contactBatchDetail)
	end

	def new
		@batch_detail = BatchDetail.lumniStart(params,current_company, list: current_user.template('BatchDetail','batch_details',current_user))
		contactBatchDetail = @batch_detail.lumniSave(params,current_user, list: current_user.template('BatchDetail','batch_details',current_user))
		lumniClose(@batch_detail,contactBatchDetail)
	end

	def create
		@batch_detail = BatchDetail.lumniStart(params,current_company, list: current_user.template('BatchDetail','batch_details',current_user))
		contactBatchDetail = @batch_detail.lumniSave(params,current_user, list: current_user.template('BatchDetail','batch_details',current_user))
		lumniClose(@batch_detail,contactBatchDetail)
	end

	def edit
		@batch_detail = BatchDetail.lumniStart(params,current_company, list: current_user.template('BatchDetail','batch_details',current_user))
		contactBatchDetail = @batch_detail.lumniSave(params,current_user, list: current_user.template('BatchDetail','batch_details',current_user))
		lumniClose(@batch_detail,contactBatchDetail)
	end

	def update
		@batch_detail = BatchDetail.lumniStart(params,current_company, list: current_user.template('BatchDetail','batch_details',current_user))
		contactBatchDetail = @batch_detail.lumniSave(params,current_user, list: current_user.template('BatchDetail','batch_details',current_user))
		lumniClose(@batch_detail,contactBatchDetail)
	end
	def destroy
		@batch_detail = BatchDetail.lumniStart(params,current_company, list: current_user.template('BatchDetail','batch_details',current_user))
		contactBatchDetail = @batch_detail.lumniSave(params,current_user, list: current_user.template('BatchDetail','batch_details',current_user))
		lumniClose(@cluster,contactBatchDetail)
	end
end