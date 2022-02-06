class IsaAmendmentDisbursementsController < ApplicationController
	def index
		@isa_amendment_disbursement = IsaAmendmentDisbursement.lumniStart(params,current_company, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		contactIsaAmendmentDisbursement = @isa_amendment_disbursement.lumniSave(params,current_user, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		lumniClose(@isa_amendment_disbursement,contactIsaAmendmentDisbursement)
	end

	def new
		@isa_amendment_disbursement = IsaAmendmentDisbursement.lumniStart(params,current_company, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		contactIsaAmendmentDisbursement = @isa_amendment_disbursement.lumniSave(params,current_user, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		lumniClose(@isa_amendment_disbursement,contactIsaAmendmentDisbursement)
	end

	def create
		@isa_amendment_disbursement = IsaAmendmentDisbursement.lumniStart(params,current_company, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		contactIsaAmendmentDisbursement = @isa_amendment_disbursement.lumniSave(params,current_user, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		lumniClose(@isa_amendment_disbursement,contactIsaAmendmentDisbursement)
	end

	def edit
		@isa_amendment_disbursement = IsaAmendmentDisbursement.lumniStart(params,current_company, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		contactIsaAmendmentDisbursement = @isa_amendment_disbursement.lumniSave(params,current_user, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		lumniClose(@isa_amendment_disbursement,contactIsaAmendmentDisbursement)
	end

	def update
		@isa_amendment_disbursement = IsaAmendmentDisbursement.lumniStart(params,current_company, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		contactIsaAmendmentDisbursement = @isa_amendment_disbursement.lumniSave(params,current_user, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		lumniClose(@isa_amendment_disbursement,contactIsaAmendmentDisbursement)
	end
	def destroy
		@isa_amendment_disbursement = IsaAmendmentDisbursement.lumniStart(params,current_company, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		contactIsaAmendmentDisbursement = @isa_amendment_disbursement.lumniSave(params,current_user, list: current_user.template('IsaAmendmentDisbursement','isa_amendment_disbursements',current_user))
		lumniClose(@cluster,contactIsaAmendmentDisbursement)
	end
end