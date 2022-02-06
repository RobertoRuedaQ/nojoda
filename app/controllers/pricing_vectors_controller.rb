class PricingVectorsController < ApplicationController
	def index
		@pricing_vector = PricingVector.lumniStart(params,current_company)
		pricingVectorResult = @pricing_vector.lumniSave(params,current_user)
		lumniClose(@pricing_vector,pricingVectorResult)
	end

	def new
		@pricing_vector = PricingVector.lumniStart(params,current_company)
		pricingVectorResult = @pricing_vector.lumniSave(params,current_user)
		lumniClose(@pricing_vector,pricingVectorResult)
	end

	def create
		@pricing_vector = PricingVector.lumniStart(params,current_company)
		pricingVectorResult = @pricing_vector.lumniSave(params,current_user)
		lumniClose(@pricing_vector,pricingVectorResult)
	end

	def edit
		@pricing_vector = PricingVector.lumniStart(params,current_company)
		pricingVectorResult = @pricing_vector.lumniSave(params,current_user)
		lumniClose(@pricing_vector,pricingVectorResult)
	end

	def update
		@pricing_vector = PricingVector.lumniStart(params,current_company)
		pricingVectorResult = @pricing_vector.lumniSave(params,current_user)
		lumniClose(@pricing_vector,pricingVectorResult)
	end
	def destroy
		@pricing_vector = PricingVector.lumniStart(params,current_company)
		pricingVectorResult = @pricing_vector.lumniSave(params,current_user)
		lumniClose(@pricing_vector,pricingVectorResult)
	end
end
