class ModelingFeesController < ApplicationController
	def index
		@modeling_fee = ModelingFee.lumniStart(params,current_company, list: current_user.template('ModelingFee','modeling_fees',current_user))
		contactModelingFee = @modeling_fee.lumniSave(params,current_user, list: current_user.template('ModelingFee','modeling_fees',current_user))
		lumniClose(@modeling_fee,contactModelingFee)
	end

	def new
		@modeling_fee = ModelingFee.lumniStart(params,current_company, list: current_user.template('ModelingFee','modeling_fees',current_user))
		set_modeling_id
		contactModelingFee = @modeling_fee.lumniSave(params,current_user, list: current_user.template('ModelingFee','modeling_fees',current_user))
		lumniClose(@modeling_fee,contactModelingFee)
	end

	def create
		@modeling_fee = ModelingFee.lumniStart(params,current_company, list: current_user.template('ModelingFee','modeling_fees',current_user))
		contactModelingFee = @modeling_fee.lumniSave(params,current_user, list: current_user.template('ModelingFee','modeling_fees',current_user))
		lumniClose(@modeling_fee,contactModelingFee)
	end

	def edit
		@modeling_fee = ModelingFee.lumniStart(params,current_company, list: current_user.template('ModelingFee','modeling_fees',current_user))
		contactModelingFee = @modeling_fee.lumniSave(params,current_user, list: current_user.template('ModelingFee','modeling_fees',current_user))
		lumniClose(@modeling_fee,contactModelingFee)
	end

	def update
		@modeling_fee = ModelingFee.lumniStart(params,current_company, list: current_user.template('ModelingFee','modeling_fees',current_user))
		contactModelingFee = @modeling_fee.lumniSave(params,current_user, list: current_user.template('ModelingFee','modeling_fees',current_user))
		lumniClose(@modeling_fee,contactModelingFee)
	end
	def destroy
		@modeling_fee = ModelingFee.lumniStart(params,current_company, list: current_user.template('ModelingFee','modeling_fees',current_user))
		contactModelingFee = @modeling_fee.lumniSave(params,current_user, list: current_user.template('ModelingFee','modeling_fees',current_user))
		lumniClose(@cluster,contactModelingFee)
	end

	private

	def set_modeling_id
		begin
			modeling = Modeling.find(params['modeling'])
			@modeling_fee.modeling_id = modeling.id
		rescue ActiveRecord::RecordNotFound => e
		end
	end
end