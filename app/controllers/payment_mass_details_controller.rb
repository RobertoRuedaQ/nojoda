class PaymentMassDetailsController < ApplicationController
	def index
		@payment_mass_detail = PaymentMassDetail.lumniStart(params,current_company, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		contactPaymentMassDetail = @payment_mass_detail.lumniSave(params,current_user, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		lumniClose(@payment_mass_detail,contactPaymentMassDetail)
	end

	def new
		@payment_mass_detail = PaymentMassDetail.lumniStart(params,current_company, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		@payment_mass_detail = params[:payment_mass_detail_id]
		contactPaymentMassDetail = @payment_mass_detail.lumniSave(params,current_user, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		lumniClose(@payment_mass_detail,contactPaymentMassDetail)
	end

	def create
		@payment_mass_detail = PaymentMassDetail.lumniStart(params,current_company, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		contactPaymentMassDetail = @payment_mass_detail.lumniSave(params,current_user, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		lumniClose(@payment_mass_detail,contactPaymentMassDetail)
	end

	def edit
		@payment_mass_detail = PaymentMassDetail.lumniStart(params,current_company, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		contactPaymentMassDetail = @payment_mass_detail.lumniSave(params,current_user, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		lumniClose(@payment_mass_detail,contactPaymentMassDetail)
	end

	def update
		@payment_mass_detail = PaymentMassDetail.lumniStart(params,current_company, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		contactPaymentMassDetail = @payment_mass_detail.lumniSave(params,current_user, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		lumniClose(@payment_mass_detail,contactPaymentMassDetail)
  end
  
	def destroy
		@payment_mass_detail = PaymentMassDetail.lumniStart(params,current_company, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		contactPaymentMassDetail = @payment_mass_detail.lumniSave(params,current_user, list: current_user.template('PaymentMassDetail','payment_mass_details',current_user))
		lumniClose(@cluster,contactPaymentMassDetail)
	end

  def search_matches
    @payment_mass_detail = PaymentMassDetail.cached_find(params[:id])
    @payment_mass_detail.get_billing_document_id
    redirect_to edit_payment_mass_detail_path(@payment_mass_detail)
  end

  def create_payments
    @payment_mass_detail = PaymentMassDetail.cached_find(params[:id])
    @payment_mass_detail.generate_payment
    redirect_to edit_payment_mass_detail_path(@payment_mass_detail)
  end
  

  def unapply_payment
    @payment_mass_detail = PaymentMassDetail.cached_find(params[:id])
    @payment_mass_detail.unapply_payment
    @payment_mass_detail.save
    redirect_to edit_payment_mass_detail_path(@payment_mass_detail)
  end
end