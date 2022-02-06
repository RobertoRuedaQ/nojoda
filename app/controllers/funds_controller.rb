class FundsController < ApplicationController

	def index
		@fund = Fund.lumniStart(params,current_company, list: current_user.template('Fund','funds',current_user,current_company: current_company)).where(company_id: helpers.my_companies.ids)
		fundResult = @fund.lumniSave(params,current_user, list: current_user.template('Fund','funds',current_user,current_company: current_company))
		lumniClose(@fund,fundResult)
	end

	def new
		@fund = Fund.lumniStart(params,current_company, list: current_user.template('Fund','funds',current_user,current_company: current_company))
		@fund.company_id = current_company.id
		fundResult = @fund.lumniSave(params,current_user, list: current_user.template('Fund','funds',current_user,current_company: current_company))
		lumniClose(@fund,fundResult)
	end

	def create
		@fund = Fund.lumniStart(params,current_company, list: current_user.template('Fund','funds',current_user,current_company: current_company))
		fundResult = @fund.lumniSave(params,current_user, list: current_user.template('Fund','funds',current_user,current_company: current_company))
		lumniClose(@fund,fundResult)
	end

	def edit
		@fund = Fund.lumniStart(params,current_company, list: current_user.template('Fund','funds',current_user,current_company: current_company))
		fundResult = @fund.lumniSave(params,current_user, list: current_user.template('Fund','funds',current_user,current_company: current_company))
		lumniClose(@fund,fundResult)
	end

	def update
		@fund = Fund.lumniStart(params,current_company, list: current_user.template('Fund','funds',current_user,current_company: current_company))
		fundResult = @fund.lumniSave(params,current_user, list: current_user.template('Fund','funds',current_user,current_company: current_company))
		lumniClose(@fund,fundResult)
	end
	def destroy
		@fund = Fund.lumniStart(params,current_company, list: current_user.template('Fund','funds',current_user,current_company: current_company))
		fundResult = @fund.lumniSave(params,current_user, list: current_user.template('Fund','funds',current_user,current_company: current_company))
		lumniClose(@cluster,fundResult)
	end


	def valuation
		fund = Fund.find(params[:id])
		ValuationHistory.create(date: Time.now, user_id: current_user.id, fund_id: fund.id,  expected_records: fund.total_funding_options_initial.count, status: 'pending')
		flash[:success] = 'La valoración ha iniciado exitosamente'
		redirect_to edit_fund_path(fund)
	end

end

