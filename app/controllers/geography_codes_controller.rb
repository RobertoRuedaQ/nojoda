class GeographyCodesController < ApplicationController
	def index
		@geography_code = GeographyCode.lumniStart(params,current_company, list: current_user.template('GeographyCode','geography_codes',current_user))
		contactGeographyCode = @geography_code.lumniSave(params,current_user, list: current_user.template('GeographyCode','geography_codes',current_user))
		lumniClose(@geography_code,contactGeographyCode)
	end

	def new
		@geography_code = GeographyCode.lumniStart(params,current_company, list: current_user.template('GeographyCode','geography_codes',current_user))
		contactGeographyCode = @geography_code.lumniSave(params,current_user, list: current_user.template('GeographyCode','geography_codes',current_user))
		lumniClose(@geography_code,contactGeographyCode)
	end

	def create
		@geography_code = GeographyCode.lumniStart(params,current_company, list: current_user.template('GeographyCode','geography_codes',current_user))
		contactGeographyCode = @geography_code.lumniSave(params,current_user, list: current_user.template('GeographyCode','geography_codes',current_user))
		lumniClose(@geography_code,contactGeographyCode)
	end

	def edit
		@geography_code = GeographyCode.lumniStart(params,current_company, list: current_user.template('GeographyCode','geography_codes',current_user))
		contactGeographyCode = @geography_code.lumniSave(params,current_user, list: current_user.template('GeographyCode','geography_codes',current_user))
		lumniClose(@geography_code,contactGeographyCode)
	end

	def update
		@geography_code = GeographyCode.lumniStart(params,current_company, list: current_user.template('GeographyCode','geography_codes',current_user))
		contactGeographyCode = @geography_code.lumniSave(params,current_user, list: current_user.template('GeographyCode','geography_codes',current_user))
		lumniClose(@geography_code,contactGeographyCode)
	end
	def destroy
		@geography_code = GeographyCode.lumniStart(params,current_company, list: current_user.template('GeographyCode','geography_codes',current_user))
		contactGeographyCode = @geography_code.lumniSave(params,current_user, list: current_user.template('GeographyCode','geography_codes',current_user))
		lumniClose(@cluster,contactGeographyCode)
	end
end