class ValuationDetailsController < ApplicationController
	def index
		@valuation_detail = ValuationDetail.lumniStart(params,current_company, list: current_user.template('ValuationDetail','valuation_details',current_user))
		contactValuationDetail = @valuation_detail.lumniSave(params,current_user, list: current_user.template('ValuationDetail','valuation_details',current_user))
		lumniClose(@valuation_detail,contactValuationDetail)
	end

	def new
		@valuation_detail = ValuationDetail.lumniStart(params,current_company, list: current_user.template('ValuationDetail','valuation_details',current_user))
		contactValuationDetail = @valuation_detail.lumniSave(params,current_user, list: current_user.template('ValuationDetail','valuation_details',current_user))
		lumniClose(@valuation_detail,contactValuationDetail)
	end

	def create
		@valuation_detail = ValuationDetail.lumniStart(params,current_company, list: current_user.template('ValuationDetail','valuation_details',current_user))
		contactValuationDetail = @valuation_detail.lumniSave(params,current_user, list: current_user.template('ValuationDetail','valuation_details',current_user))
		lumniClose(@valuation_detail,contactValuationDetail)
	end

	def edit
		@valuation_detail = ValuationDetail.lumniStart(params,current_company, list: current_user.template('ValuationDetail','valuation_details',current_user))
		contactValuationDetail = @valuation_detail.lumniSave(params,current_user, list: current_user.template('ValuationDetail','valuation_details',current_user))
		lumniClose(@valuation_detail,contactValuationDetail)
	end

	def update
		@valuation_detail = ValuationDetail.lumniStart(params,current_company, list: current_user.template('ValuationDetail','valuation_details',current_user))
		contactValuationDetail = @valuation_detail.lumniSave(params,current_user, list: current_user.template('ValuationDetail','valuation_details',current_user))
		lumniClose(@valuation_detail,contactValuationDetail)
	end
	def destroy
		@valuation_detail = ValuationDetail.lumniStart(params,current_company, list: current_user.template('ValuationDetail','valuation_details',current_user))
		contactValuationDetail = @valuation_detail.lumniSave(params,current_user, list: current_user.template('ValuationDetail','valuation_details',current_user))
		lumniClose(@cluster,contactValuationDetail)
	end
end