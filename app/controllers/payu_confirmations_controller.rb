class PayuConfirmationsController < ApplicationController
	def index
		@payu_confirmation = PayuConfirmation.lumniStart(params,current_company, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		contactPayuConfirmation = @payu_confirmation.lumniSave(params,current_user, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		lumniClose(@payu_confirmation,contactPayuConfirmation)
	end

	def new
		@payu_confirmation = PayuConfirmation.lumniStart(params,current_company, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		contactPayuConfirmation = @payu_confirmation.lumniSave(params,current_user, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		lumniClose(@payu_confirmation,contactPayuConfirmation)
	end

	def create
		@payu_confirmation = PayuConfirmation.lumniStart(params,current_company, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		contactPayuConfirmation = @payu_confirmation.lumniSave(params,current_user, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		lumniClose(@payu_confirmation,contactPayuConfirmation)
	end

	def edit
		@payu_confirmation = PayuConfirmation.lumniStart(params,current_company, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		contactPayuConfirmation = @payu_confirmation.lumniSave(params,current_user, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		lumniClose(@payu_confirmation,contactPayuConfirmation)
	end

	def update
		@payu_confirmation = PayuConfirmation.lumniStart(params,current_company, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		contactPayuConfirmation = @payu_confirmation.lumniSave(params,current_user, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		lumniClose(@payu_confirmation,contactPayuConfirmation)
	end
	def destroy
		@payu_confirmation = PayuConfirmation.lumniStart(params,current_company, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		contactPayuConfirmation = @payu_confirmation.lumniSave(params,current_user, list: current_user.template('PayuConfirmation','payu_confirmations',current_user))
		lumniClose(@cluster,contactPayuConfirmation)
	end

	def payu_confirmation

		puts "Estos son los params!!: #{params}"

		@payu_confirmation = PayuConfirmation.find_by_reference_sale(params['id'])

		if @payu_confirmation.nil?
			@payu_confirmation = PayuConfirmation.new(reference_sale: params[:id])
		end

		target_keys = params.keys - ['id','action','controller','payu_confirmation']
		target_keys.each do |key|
			begin
				eval("@payu_confirmation.#{key.downcase} = params['#{key}']")
			rescue Exception => e
				nil
			end
		end
		@payu_confirmation.save!
	end

end