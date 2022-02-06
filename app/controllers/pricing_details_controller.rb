class PricingDetailsController < ApplicationController
	def index
		@pricing_detail = PricingDetail.lumniStart(params,current_company)
		pricingDetailResult = @pricing_detail.lumniSave(params,current_user)
		lumniClose(@pricing_detail,pricingDetailResult)
	end

	def new
		@pricing_detail = PricingDetail.lumniStart(params,current_company)
		pricingDetailResult = @pricing_detail.lumniSave(params,current_user)
		lumniClose(@pricing_detail,pricingDetailResult)
	end

	def create
		@pricing_detail = PricingDetail.lumniStart(params,current_company)
		pricingDetailResult = @pricing_detail.lumniSave(params,current_user)
		lumniClose(@pricing_detail,pricingDetailResult)
	end

	def edit
		@pricing_detail = PricingDetail.lumniStart(params,current_company)
		pricingDetailResult = @pricing_detail.lumniSave(params,current_user)
		lumniClose(@pricing_detail,pricingDetailResult)
	end

	def update
		@pricing_detail = PricingDetail.lumniStart(params,current_company)
		pricingDetailResult = @pricing_detail.lumniSave(params,current_user)
		lumniClose(@pricing_detail,pricingDetailResult)
	end
	def destroy
		@pricing_detail = PricingDetail.lumniStart(params,current_company)
		pricingDetailResult = @pricing_detail.lumniSave(params,current_user)
		lumniClose(@pricing_detail,pricingDetailResult)
	end
end
