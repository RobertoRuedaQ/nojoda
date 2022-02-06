class FundWithdrawalsController < ApplicationController
	def index
		@fund_withdrawal = FundWithdrawal.lumniStart(params,current_company, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		contactFundWithdrawal = @fund_withdrawal.lumniSave(params,current_user, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		lumniClose(@fund_withdrawal,contactFundWithdrawal)
	end

	def new
		@fund_withdrawal = FundWithdrawal.lumniStart(params,current_company, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		contactFundWithdrawal = @fund_withdrawal.lumniSave(params,current_user, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		lumniClose(@fund_withdrawal,contactFundWithdrawal)
	end

	def create
		@fund_withdrawal = FundWithdrawal.lumniStart(params,current_company, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		contactFundWithdrawal = @fund_withdrawal.lumniSave(params,current_user, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		lumniClose(@fund_withdrawal,contactFundWithdrawal)
		@isa = Isa.cached_find(params[:temp][:isa_id])
	end

	def edit
		@fund_withdrawal = FundWithdrawal.lumniStart(params,current_company, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		contactFundWithdrawal = @fund_withdrawal.lumniSave(params,current_user, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		lumniClose(@fund_withdrawal,contactFundWithdrawal)
	end

	def update
		@fund_withdrawal = FundWithdrawal.lumniStart(params,current_company, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		contactFundWithdrawal = @fund_withdrawal.lumniSave(params,current_user, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		lumniClose(@fund_withdrawal,contactFundWithdrawal)
		@isa = Isa.cached_find(params[:temp][:isa_id])
	end
	def destroy
		@fund_withdrawal = FundWithdrawal.lumniStart(params,current_company, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		contactFundWithdrawal = @fund_withdrawal.lumniSave(params,current_user, list: current_user.template('FundWithdrawal','fund_withdrawals',current_user))
		lumniClose(@cluster,contactFundWithdrawal)
	end

	def create_application
    application = Application.where(user_id: current_user.id, status: 'under_review', application_case: 'fund_withdrawals').first
    if application.nil?
      @fund_withdrawal = FundWithdrawal.create(isa_id: current_user.active_isa.first.id)
      application = Application.new({status: 'active',user_id: current_user.id,application_case: 'fund_withdrawals',resource_type: 'FundWithdrawal', resource_id: @fund_withdrawal.id})
      if application.save
        redirect_to edit_application_path(application)
      else
        redirect_to root_path
      end
    else
      redirect_to edit_application_path(application)
    end
  end
end