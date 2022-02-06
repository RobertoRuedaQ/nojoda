class PaymentMassesController < ApplicationController
	def index
		@payment_mass = PaymentMass.where.not(id: 98).lumniStart(params,current_company, list: current_user.template('PaymentMass','payment_masses',current_user))
		contactPaymentMass = @payment_mass.lumniSave(params,current_user, list: current_user.template('PaymentMass','payment_masses',current_user))
		lumniClose(@payment_mass,contactPaymentMass)
	end

	def new
		@payment_mass = PaymentMass.lumniStart(params,current_company, list: current_user.template('PaymentMass','payment_masses',current_user))
		@payment_mass.company_id = current_company.id
		contactPaymentMass = @payment_mass.lumniSave(params,current_user, list: current_user.template('PaymentMass','payment_masses',current_user))
		lumniClose(@payment_mass,contactPaymentMass)
	end

	def create
		@payment_mass = PaymentMass.lumniStart(params,current_company, list: current_user.template('PaymentMass','payment_masses',current_user))
		contactPaymentMass = @payment_mass.lumniSave(params,current_user, list: current_user.template('PaymentMass','payment_masses',current_user))
		lumniClose(@payment_mass,contactPaymentMass)
	end

	def edit
		@payment_mass = PaymentMass.lumniStart(params,current_company, list: current_user.template('PaymentMass','payment_masses',current_user))
		contactPaymentMass = @payment_mass.lumniSave(params,current_user, list: current_user.template('PaymentMass','payment_masses',current_user))
		lumniClose(@payment_mass,contactPaymentMass)
	end

	def update
		@payment_mass = PaymentMass.lumniStart(params,current_company, list: current_user.template('PaymentMass','payment_masses',current_user))
		contactPaymentMass = @payment_mass.lumniSave(params,current_user, list: current_user.template('PaymentMass','payment_masses',current_user))
		lumniClose(@payment_mass,contactPaymentMass)
	end
	def destroy
		@payment_mass = PaymentMass.lumniStart(params,current_company, list: current_user.template('PaymentMass','payment_masses',current_user))
		contactPaymentMass = @payment_mass.lumniSave(params,current_user, list: current_user.template('PaymentMass','payment_masses',current_user))
		lumniClose(@cluster,contactPaymentMass)
	end
end