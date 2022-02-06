class PayuGatewaysController < ApplicationController
	def index
		@payu_gateway = PayuGateway.lumniStart(params,current_company, list: current_user.template('PayuGateway','payu_gateways',current_user))
		contactPayuGateway = @payu_gateway.lumniSave(params,current_user, list: current_user.template('PayuGateway','payu_gateways',current_user))
		lumniClose(@payu_gateway,contactPayuGateway)
	end

	def new
		@payu_gateway = PayuGateway.lumniStart(params,current_company, list: current_user.template('PayuGateway','payu_gateways',current_user))
		@payu_gateway.company_id = current_company.id
		contactPayuGateway = @payu_gateway.lumniSave(params,current_user, list: current_user.template('PayuGateway','payu_gateways',current_user))
		lumniClose(@payu_gateway,contactPayuGateway)
	end

	def create
		@payu_gateway = PayuGateway.lumniStart(params,current_company, list: current_user.template('PayuGateway','payu_gateways',current_user))
		contactPayuGateway = @payu_gateway.lumniSave(params,current_user, list: current_user.template('PayuGateway','payu_gateways',current_user))
		lumniClose(@payu_gateway,contactPayuGateway)
	end

	def edit
		@payu_gateway = PayuGateway.lumniStart(params,current_company, list: current_user.template('PayuGateway','payu_gateways',current_user))
		contactPayuGateway = @payu_gateway.lumniSave(params,current_user, list: current_user.template('PayuGateway','payu_gateways',current_user))
		lumniClose(@payu_gateway,contactPayuGateway)
	end

	def update
		@payu_gateway = PayuGateway.lumniStart(params,current_company, list: current_user.template('PayuGateway','payu_gateways',current_user))
		contactPayuGateway = @payu_gateway.lumniSave(params,current_user, list: current_user.template('PayuGateway','payu_gateways',current_user))
		lumniClose(@payu_gateway,contactPayuGateway)
	end
	def destroy
		@payu_gateway = PayuGateway.lumniStart(params,current_company, list: current_user.template('PayuGateway','payu_gateways',current_user))
		contactPayuGateway = @payu_gateway.lumniSave(params,current_user, list: current_user.template('PayuGateway','payu_gateways',current_user))
		lumniClose(@cluster,contactPayuGateway)
	end
end