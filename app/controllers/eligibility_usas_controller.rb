class EligibilityUsasController < ApplicationController
	def index
		@eligibility_usa = EligibilityUsa.lumniStart(params,current_company)
		eligibilityUsaResult = @eligibility_usa.lumniSave(params,current_user)
		lumniClose(@eligibility_usa,eligibilityUsaResult)
	end

	def new
		@eligibility_usa = EligibilityUsa.lumniStart(params,current_company)
		eligibilityUsaResult = @eligibility_usa.lumniSave(params,current_user)
		lumniClose(@eligibility_usa,eligibilityUsaResult)
	end

	def create
		@eligibility_usa = EligibilityUsa.lumniStart(params,current_company)
		eligibilityUsaResult = @eligibility_usa.lumniSave(params,current_user)
		lumniClose(@eligibility_usa,eligibilityUsaResult)
	end

	def edit
		@eligibility_usa = EligibilityUsa.lumniStart(params,current_company)
		eligibilityUsaResult = @eligibility_usa.lumniSave(params,current_user)
		lumniClose(@eligibility_usa,eligibilityUsaResult)
	end

	def update
		@eligibility_usa = EligibilityUsa.lumniStart(params,current_company)
		eligibilityUsaResult = @eligibility_usa.lumniSave(params,current_user)
		lumniClose(@eligibility_usa,eligibilityUsaResult)
	end
	def destroy
		@eligibility_usa = EligibilityUsa.lumniStart(params,current_company)
		eligibilityUsaResult = @eligibility_usa.lumniSave(params,current_user)
		lumniClose(@cluster,eligibilityUsaResult)
	end
end
