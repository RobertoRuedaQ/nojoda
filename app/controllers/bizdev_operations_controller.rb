class BizdevOperationsController < ApplicationController
	def index
		@bizdev_operation = BizdevOperation.lumniStart(params,current_company, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		contactBizdevOperation = @bizdev_operation.lumniSave(params,current_user, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		lumniClose(@bizdev_operation,contactBizdevOperation)
	end

	def new
		@bizdev_operation = BizdevOperation.lumniStart(params,current_company, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		@bizdev_operation.created_by_id = current_user.id
		contactBizdevOperation = @bizdev_operation.lumniSave(params,current_user, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		lumniClose(@bizdev_operation,contactBizdevOperation)
	end

	def create
		@bizdev_operation = BizdevOperation.lumniStart(params,current_company, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		contactBizdevOperation = @bizdev_operation.lumniSave(params,current_user, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		lumniClose(@bizdev_operation,contactBizdevOperation)
	end

	def edit
		@bizdev_operation = BizdevOperation.lumniStart(params,current_company, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		contactBizdevOperation = @bizdev_operation.lumniSave(params,current_user, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		lumniClose(@bizdev_operation,contactBizdevOperation)
	end

	def update
		@bizdev_operation = BizdevOperation.lumniStart(params,current_company, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		contactBizdevOperation = @bizdev_operation.lumniSave(params,current_user, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		lumniClose(@bizdev_operation,contactBizdevOperation)
	end
	def destroy
		@bizdev_operation = BizdevOperation.lumniStart(params,current_company, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		contactBizdevOperation = @bizdev_operation.lumniSave(params,current_user, list: current_user.template('BizdevOperation','bizdev_operations',current_user))
		lumniClose(@cluster,contactBizdevOperation)
	end
end