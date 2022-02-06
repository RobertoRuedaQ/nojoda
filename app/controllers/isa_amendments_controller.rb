class IsaAmendmentsController < ApplicationController
	def index
		@isa_amendment = IsaAmendment.lumniStart(params,current_company, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		contactIsaAmendment = @isa_amendment.lumniSave(params,current_user, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		lumniClose(@isa_amendment,contactIsaAmendment)
	end

	def new
		@isa_amendment = IsaAmendment.lumniStart(params,current_company, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		@isa_amendment.isa_id = params[:isa_id]
		@isa_amendment.user_id = current_user.id
		contactIsaAmendment = @isa_amendment.lumniSave(params,current_user, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		lumniClose(@isa_amendment,contactIsaAmendment)
	end

	def create
		@isa_amendment = IsaAmendment.lumniStart(params,current_company, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		contactIsaAmendment = @isa_amendment.lumniSave(params,current_user, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		lumniClose(@isa_amendment,contactIsaAmendment)
	end

	def edit
		@isa_amendment = IsaAmendment.lumniStart(params,current_company, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		contactIsaAmendment = @isa_amendment.lumniSave(params,current_user, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		lumniClose(@isa_amendment,contactIsaAmendment)
	end

	def update
		@isa_amendment = IsaAmendment.lumniStart(params,current_company, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		contactIsaAmendment = @isa_amendment.lumniSave(params,current_user, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		lumniClose(@isa_amendment,contactIsaAmendment)
	end
	def destroy
		@isa_amendment = IsaAmendment.lumniStart(params,current_company, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		contactIsaAmendment = @isa_amendment.lumniSave(params,current_user, list: current_user.template('IsaAmendment','isa_amendments',current_user))
		lumniClose(@cluster,contactIsaAmendment)
	end
end