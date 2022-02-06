class MercadoPagoGatewaysController < ApplicationController
	def index
		@mercado_pago_gateway = MercadoPagoGateway.lumniStart(params,current_company, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		contactMercadoPagoGateway = @mercado_pago_gateway.lumniSave(params,current_user, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		lumniClose(@mercado_pago_gateway,contactMercadoPagoGateway)
	end

	def new
		@mercado_pago_gateway = MercadoPagoGateway.lumniStart(params,current_company, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		@mercado_pago_gateway.company_id = current_company.id
		contactMercadoPagoGateway = @mercado_pago_gateway.lumniSave(params,current_user, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		lumniClose(@mercado_pago_gateway,contactMercadoPagoGateway)
	end

	def create
		@mercado_pago_gateway = MercadoPagoGateway.lumniStart(params,current_company, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		contactMercadoPagoGateway = @mercado_pago_gateway.lumniSave(params,current_user, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		lumniClose(@mercado_pago_gateway,contactMercadoPagoGateway)
	end

	def edit
		@mercado_pago_gateway = MercadoPagoGateway.lumniStart(params,current_company, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		contactMercadoPagoGateway = @mercado_pago_gateway.lumniSave(params,current_user, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		lumniClose(@mercado_pago_gateway,contactMercadoPagoGateway)
	end

	def update
		@mercado_pago_gateway = MercadoPagoGateway.lumniStart(params,current_company, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		contactMercadoPagoGateway = @mercado_pago_gateway.lumniSave(params,current_user, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		lumniClose(@mercado_pago_gateway,contactMercadoPagoGateway)
	end
	def destroy
		@mercado_pago_gateway = MercadoPagoGateway.lumniStart(params,current_company, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		contactMercadoPagoGateway = @mercado_pago_gateway.lumniSave(params,current_user, list: current_user.template('MercadoPagoGateway','mercado_pago_gateways',current_user))
		lumniClose(@cluster,contactMercadoPagoGateway)
	end
end