class PricingTablesController < ApplicationController
	def index
		@pricing_table = PricingTable.lumniStart(params,current_company)
		pricingTableResult = @pricing_table.lumniSave(params,current_user)
		lumniClose(@pricing_table,pricingTableResult)
	end

	def new
		@pricing_table = PricingTable.lumniStart(params,current_company)
		pricingTableResult = @pricing_table.lumniSave(params,current_user)
		lumniClose(@pricing_table,pricingTableResult)
	end

	def create
		@pricing_table = PricingTable.lumniStart(params,current_company)
		pricingTableResult = @pricing_table.lumniSave(params,current_user)
		lumniClose(@pricing_table,pricingTableResult)
	end

	def edit
		@pricing_table = PricingTable.lumniStart(params,current_company)
		pricingTableResult = @pricing_table.lumniSave(params,current_user)
		lumniClose(@pricing_table,pricingTableResult)
	end

	def update
		@pricing_table = PricingTable.lumniStart(params,current_company)
		pricingTableResult = @pricing_table.lumniSave(params,current_user)
		lumniClose(@pricing_table,pricingTableResult)
	end
	def destroy
		@pricing_table = PricingTable.lumniStart(params,current_company)
		pricingTableResult = @pricing_table.lumniSave(params,current_user)
		lumniClose(@pricing_table,pricingTableResult)
	end
end
