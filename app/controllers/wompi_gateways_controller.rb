class WompiGatewaysController < ApplicationController
	def index
		@wompi_gateway = WompiGateway.lumniStart(params,current_company, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		contactWompiGateway = @wompi_gateway.lumniSave(params,current_user, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		lumniClose(@wompi_gateway,contactWompiGateway)
	end

	def new
		@wompi_gateway = WompiGateway.lumniStart(params,current_company, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		@wompi_gateway.company_id = current_company.id
		contactWompiGateway = @wompi_gateway.lumniSave(params,current_user, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		lumniClose(@wompi_gateway,contactWompiGateway)
	end

	def create
		@wompi_gateway = WompiGateway.lumniStart(params,current_company, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		contactWompiGateway = @wompi_gateway.lumniSave(params,current_user, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		lumniClose(@wompi_gateway,contactWompiGateway)
	end

	def edit
		@wompi_gateway = WompiGateway.lumniStart(params,current_company, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		contactWompiGateway = @wompi_gateway.lumniSave(params,current_user, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		lumniClose(@wompi_gateway,contactWompiGateway)
	end

	def update
		@wompi_gateway = WompiGateway.lumniStart(params,current_company, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		contactWompiGateway = @wompi_gateway.lumniSave(params,current_user, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		lumniClose(@wompi_gateway,contactWompiGateway)
	end
	def destroy
		@wompi_gateway = WompiGateway.lumniStart(params,current_company, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		contactWompiGateway = @wompi_gateway.lumniSave(params,current_user, list: current_user.template('WompiGateway','wompi_gateways',current_user))
		lumniClose(@cluster,contactWompiGateway)
	end
end