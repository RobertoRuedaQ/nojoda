class CompaniesController < ApplicationController
	def index
		@company = Company.lumniStart(params,current_company,list: companies_fields(current_company))
		companyResult = @company.lumniSave(params,current_user, list: companies_fields(current_company))
		lumniClose(@company,companyResult)
	end

	def new
		@company = Company.lumniStart(params,current_company,list: companies_fields(current_company))
		companyResult = @company.lumniSave(params,current_user, list: companies_fields(current_company))
		lumniClose(@company,companyResult)
	end

	def create
		@company = Company.lumniStart(params,current_company,list: companies_fields(current_company))
		companyResult = @company.lumniSave(params,current_user, list: companies_fields(current_company))
		lumniClose(@company,companyResult)
	end

	def edit
		@company = Company.lumniStart(params,current_company,list: companies_fields(current_company))
		companyResult = @company.lumniSave(params,current_user, list: companies_fields(current_company))
		lumniClose(@company,companyResult)
	end

	def update

		@company = Company.lumniStart(params,current_company,list: companies_fields(current_company))
		companyResult = @company.lumniSave(params,current_user, list: companies_fields(current_company))
		lumniClose(@company,companyResult)
	end
	def destroy
		@company = Company.lumniStart(params,current_company,list: companies_fields(current_company))
		companyResult = @company.lumniSave(params,current_user, list: companies_fields(current_company))
		lumniClose(@cluster,companyResult)
	end

end
