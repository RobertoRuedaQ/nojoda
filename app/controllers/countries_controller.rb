class CountriesController < ApplicationController
	def index
		@country = Country.lumniStart(params,current_company,list:  current_user.template('Country','countries',current_user))
		countryResult = @country.lumniSave(params,current_user,list:  current_user.template('Country','countries',current_user))
		lumniClose(@country,countryResult,list:  current_user.template('Country','countries',current_user))
	end

	def new
		@country = Country.lumniStart(params,current_company,list:  current_user.template('Country','countries',current_user))
		countryResult = @country.lumniSave(params,current_user,list:  current_user.template('Country','countries',current_user))
		lumniClose(@country,countryResult,list:  current_user.template('Country','countries',current_user))
	end

	def create
		@country = Country.lumniStart(params,current_company,list:  country_fields)
		countryResult = @country.lumniSave(params,current_user,list:  country_fields)
		lumniClose(@country,countryResult,list:  country_fields)
	end

	def edit
		@country = Country.lumniStart(params,current_company,list:  current_user.template('Country','countries',current_user))
		countryResult = @country.lumniSave(params,current_user,list:  current_user.template('Country','countries',current_user))
		lumniClose(@country,countryResult,list:  current_user.template('Country','countries',current_user))
	end

	def update
		@country = Country.lumniStart(params,current_company,list:  current_user.template('Country','countries',current_user))
		countryResult = @country.lumniSave(params,current_user,list:  current_user.template('Country','countries',current_user))
		lumniClose(@country,countryResult,list:  current_user.template('Country','countries',current_user))
	end
	def destroy
		@country = Country.lumniStart(params,current_company,list:  current_user.template('Country','countries',current_user))
		countryResult = @country.lumniSave(params,current_user,list:  current_user.template('Country','countries',current_user))
		lumniClose(@cluster,countryResult,list:  current_user.template('Country','countries',current_user))
	end
end
