class PaymentBatchesController < ApplicationController
	def index
		@payment_batch = PaymentBatch.from_my_companies(current_company.my_companies.ids).where(migrated: nil).lumniStart(params,current_company, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		contactPaymentBatch = @payment_batch.lumniSave(params,current_user, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		lumniClose(@payment_batch,contactPaymentBatch)
	end

	def new
		@payment_batch = PaymentBatch.lumniStart(params,current_company, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		@payment_batch.year = (Time.now - 1.month).year
		@payment_batch.month = (Time.now - 1.month).month
		@payment_batch.status = 'under_review'
		contactPaymentBatch = @payment_batch.lumniSave(params,current_user, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		lumniClose(@payment_batch,contactPaymentBatch)
	end

	def create
		@payment_batch = PaymentBatch.lumniStart(params,current_company, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		contactPaymentBatch = @payment_batch.lumniSave(params,current_user, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		lumniClose(@payment_batch,contactPaymentBatch)
	end

	def edit
		@payment_batch = PaymentBatch.includes(billing_document: :isa).lumniStart(params,current_company, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		contactPaymentBatch = @payment_batch.lumniSave(params,current_user, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		@batch_detail_stats = @payment_batch.batch_detail.group(:status).size
		lumniClose(@payment_batch,contactPaymentBatch)
	end

	def update
		@payment_batch = PaymentBatch.lumniStart(params,current_company, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		contactPaymentBatch = @payment_batch.lumniSave(params,current_user, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		lumniClose(@payment_batch,contactPaymentBatch)
	end
	def destroy
		@payment_batch = PaymentBatch.lumniStart(params,current_company, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		contactPaymentBatch = @payment_batch.lumniSave(params,current_user, list: current_user.template('PaymentBatch','payment_batches',current_user,current_company: current_company))
		lumniClose(@cluster,contactPaymentBatch)
	end





end