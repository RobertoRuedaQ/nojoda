class BillingDocumentsController < ApplicationController
	def index
		@billing_document = BillingDocument.lumniStart(params,current_company, list: current_user.template('BillingDocument','billing_documents',current_user))
		contactBillingDocument = @billing_document.lumniSave(params,current_user, list: current_user.template('BillingDocument','billing_documents',current_user))
		lumniClose(@billing_document,contactBillingDocument)
	end

	def new
		@billing_document = BillingDocument.lumniStart(params,current_company, list: current_user.template('BillingDocument','billing_documents',current_user))
		contactBillingDocument = @billing_document.lumniSave(params,current_user, list: current_user.template('BillingDocument','billing_documents',current_user))
		lumniClose(@billing_document,contactBillingDocument)
	end

	def create
		@billing_document = BillingDocument.lumniStart(params,current_company, list: current_user.template('BillingDocument','billing_documents',current_user))
		contactBillingDocument = @billing_document.lumniSave(params,current_user, list: current_user.template('BillingDocument','billing_documents',current_user))
		lumniClose(@billing_document,contactBillingDocument)
	end

	def edit
		@billing_document = BillingDocument.lumniStart(params,current_company, list: current_user.template('BillingDocument','billing_documents',current_user))
		contactBillingDocument = @billing_document.lumniSave(params,current_user, list: current_user.template('BillingDocument','billing_documents',current_user))
		lumniClose(@billing_document,contactBillingDocument)
	end

	def update
		@billing_document = BillingDocument.lumniStart(params,current_company, list: current_user.template('BillingDocument','billing_documents',current_user))
		contactBillingDocument = @billing_document.lumniSave(params,current_user, list: current_user.template('BillingDocument','billing_documents',current_user))
		lumniClose(@billing_document,contactBillingDocument)
	end
	def destroy
		@billing_document = BillingDocument.lumniStart(params,current_company, list: current_user.template('BillingDocument','billing_documents',current_user))
		contactBillingDocument = @billing_document.lumniSave(params,current_user, list: current_user.template('BillingDocument','billing_documents',current_user))
		lumniClose(@cluster,contactBillingDocument)
	end

	def show
		@billing_document = BillingDocument.cached_find(params[:id])
		@gateway = @billing_document.gateway

		if @billing_document.user.id != current_user.id && current_user.student?
			redirect_to root_path
		end
	end

	def generate_document
		batch = PaymentBatch.find_by(year: params[:payment_batch][:year],month: params[:payment_batch][:month],fund_id: params[:payment_batch][:fund_id])
		isa = Isa.find(params[:payment_batch][:isa_id])
		isa.generate_billing_document(batch)
		redirect_to edit_student_path(isa.user)
	end

	def refresh_billing_document
		@billing_document = BillingDocument.cached_find(params[:id])
		@billing_document.refresh
		
		redirect_to edit_student_path(@billing_document.isa.user)
	end

	def update_status
		@billing_document = BillingDocument.cached_find(params[:id])
		isa = @billing_document.isa
		@billing_document.touch_status
		redirect_to edit_student_path(isa.user)
	end

	def activate_billing_document
		@billing_document = BillingDocument.cached_find(params[:id])
		@billing_document.activate_billing_document
		isa = @billing_document.isa
		redirect_to edit_student_path(isa.user_id)
	end


  def set_payment
    @payment_info = PaymentInfo.new
    @payment_info.set_dummy_values if Rails.env.development?
    @payment_info.set_default_payer_info(current_user)
    @payment_info.base = params[:target][:value]
    @payment_info.tax = 0
    @payment_info.value = params[:target][:value]
    @payment_info.order_id = params[:billing_document][:id]
    @payment_info.device_session_id = Digest::MD5.hexdigest("#{session.id}#{(Time.zone.now.to_f*1000).to_i.to_s}")
    @payment_info.device_session_id_with_user_id = "#{@payment_info.device_session_id}80200"
    @billing_document = BillingDocument.cached_find(params[:billing_document][:id])
    if @billing_document.present?
      @pse_info = PseInfo.new
      colocar_dependencias
    else
      redirect_to root_path
    end
  end


  def set_webcheckout
  	if !params[:value].nil? && !params[:transaction_id].nil?
  		@billing_document = BillingDocument.cached_find(params[:id])
  		@transaction = PayuTransaction.find_by_external_id(params[:transaction_id])
  		@transaction.update(value: params[:value])
  		@signature = @billing_document.gateway.signature( @transaction.external_id, @transaction.value,@billing_document.currency)
  	end
  end


private

  def colocar_dependencias
    @years = ( Time.zone.now.year..Time.zone.now.year+20 )
    @months = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
    @gateway = @billing_document.gateway
    @franchises = @gateway.get_credit_cards_supported
    @banks = @gateway.get_debit_cards_supported 
    @id_types = @gateway.get_id_types_supported
    @customer_types = @gateway.get_customer_types_supported
    @cash_methods_supported = @gateway.get_cash_methods_supported(@payment_info.value.to_f)
    @cuotas = ['1', '3', '6', '9', '12']
  end



end