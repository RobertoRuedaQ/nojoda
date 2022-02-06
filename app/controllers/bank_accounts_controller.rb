class BankAccountsController < ApplicationController
	def index
		@bank_account = BankAccount.lumniStart(params,current_company, list: current_user.template('BankAccount','bank_accounts',current_user))
		contactBankAccount = @bank_account.lumniSave(params,current_user, list: current_user.template('BankAccount','bank_accounts',current_user))
		lumniClose(@bank_account,contactBankAccount)
	end

	def new
		@bank_account = BankAccount.lumniStart(params,current_company, list: current_user.template('BankAccount','bank_accounts',current_user))
		if !params[:resource_type].nil? && !params[:resource_id].nil?
			@bank_account.resource_id = params[:resource_id]
			@bank_account.resource_type = params[:resource_type]
		end
		contactBankAccount = @bank_account.lumniSave(params,current_user, list: current_user.template('BankAccount','bank_accounts',current_user))
		lumniClose(@bank_account,contactBankAccount)
	end

	def create
		@bank_account = BankAccount.lumniStart(params,current_company, list: current_user.template('BankAccount','bank_accounts',current_user))
		contactBankAccount = @bank_account.lumniSave(params,current_user, list: current_user.template('BankAccount','bank_accounts',current_user))
		redirect_to eval("edit_#{@bank_account.resource_type.underscore}_path(#{@bank_account.resource_id})")
	end

	def edit
		@bank_account = BankAccount.lumniStart(params,current_company, list: current_user.template('BankAccount','bank_accounts',current_user))
		contactBankAccount = @bank_account.lumniSave(params,current_user, list: current_user.template('BankAccount','bank_accounts',current_user))
		lumniClose(@bank_account,contactBankAccount)
	end

	def update
		@bank_account = BankAccount.lumniStart(params,current_company, list: current_user.template('BankAccount','bank_accounts',current_user))
		contactBankAccount = @bank_account.lumniSave(params,current_user, list: current_user.template('BankAccount','bank_accounts',current_user))
		lumniClose(@bank_account,contactBankAccount)
	end
	def destroy
		@bank_account = BankAccount.lumniStart(params,current_company, list: current_user.template('BankAccount','bank_accounts',current_user))
		contactBankAccount = @bank_account.lumniSave(params,current_user, list: current_user.template('BankAccount','bank_accounts',current_user))
		lumniClose(@cluster,contactBankAccount)
	end

	def create_application
    application = Application.where(user_id: current_user.id, status: 'under_review', application_case: 'bank_account').first
    if application.nil?
      @bank_account = BankAccount.create(resource_type: "User", resource_id: current_user.id, status: 'under_review')
      application = Application.new({status: 'active',user_id: current_user.id,application_case: 'bank_account',resource_type: 'BankAccount', resource_id: @bank_account.id})
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