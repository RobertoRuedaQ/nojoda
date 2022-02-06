class PaymentMassDocsController < ApplicationController
	def index
		@payment_mass_doc = PaymentMassDoc.lumniStart(params,current_company, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		contactPaymentMassDoc = @payment_mass_doc.lumniSave(params,current_user, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		lumniClose(@payment_mass_doc,contactPaymentMassDoc)
	end

	def new
		@payment_mass_doc = PaymentMassDoc.lumniStart(params,current_company, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		contactPaymentMassDoc = @payment_mass_doc.lumniSave(params,current_user, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		lumniClose(@payment_mass_doc,contactPaymentMassDoc)
	end

	def create
		@payment_mass_doc = PaymentMassDoc.lumniStart(params,current_company, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		contactPaymentMassDoc = @payment_mass_doc.lumniSave(params,current_user, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		lumniClose(@payment_mass_doc,contactPaymentMassDoc)
	end

	def edit
		@payment_mass_doc = PaymentMassDoc.lumniStart(params,current_company, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		contactPaymentMassDoc = @payment_mass_doc.lumniSave(params,current_user, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		lumniClose(@payment_mass_doc,contactPaymentMassDoc)
	end

	def update
		@payment_mass_doc = PaymentMassDoc.lumniStart(params,current_company, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		contactPaymentMassDoc = @payment_mass_doc.lumniSave(params,current_user, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		lumniClose(@payment_mass_doc,contactPaymentMassDoc)
	end
	def destroy
		@payment_mass_doc = PaymentMassDoc.lumniStart(params,current_company, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		contactPaymentMassDoc = @payment_mass_doc.lumniSave(params,current_user, list: current_user.template('PaymentMassDoc','payment_mass_docs',current_user))
		lumniClose(@cluster,contactPaymentMassDoc)
	end
end