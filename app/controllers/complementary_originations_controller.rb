class ComplementaryOriginationsController < ApplicationController
	def index
		@complementary_origination = ComplementaryOrigination.lumniStart(params,current_company, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		contactComplementaryOrigination = @complementary_origination.lumniSave(params,current_user, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		lumniClose(@complementary_origination,contactComplementaryOrigination)
	end

	def new
		@complementary_origination = ComplementaryOrigination.lumniStart(params,current_company, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		contactComplementaryOrigination = @complementary_origination.lumniSave(params,current_user, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		lumniClose(@complementary_origination,contactComplementaryOrigination)
	end

	def create
		@complementary_origination = ComplementaryOrigination.lumniStart(params,current_company, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		contactComplementaryOrigination = @complementary_origination.lumniSave(params,current_user, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		lumniClose(@complementary_origination,contactComplementaryOrigination)
	end

	def edit
		@complementary_origination = ComplementaryOrigination.lumniStart(params,current_company, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		contactComplementaryOrigination = @complementary_origination.lumniSave(params,current_user, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		lumniClose(@complementary_origination,contactComplementaryOrigination)
	end

	def update
		@complementary_origination = ComplementaryOrigination.lumniStart(params,current_company, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		contactComplementaryOrigination = @complementary_origination.lumniSave(params,current_user, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		lumniClose(@complementary_origination,contactComplementaryOrigination)
	end
	def destroy
		@complementary_origination = ComplementaryOrigination.lumniStart(params,current_company, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		contactComplementaryOrigination = @complementary_origination.lumniSave(params,current_user, list: current_user.template('ComplementaryOrigination','complementary_originations',current_user))
		lumniClose(@cluster,contactComplementaryOrigination)
	end
end