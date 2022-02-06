class OriginationsController < ApplicationController
	
	def index
		@origination = Origination.lumniStart(params,current_company, list: current_user.template('Origination','originations',current_user))
		contactOrigination = @origination.lumniSave(params,current_user, list: current_user.template('Origination','originations',current_user))
		lumniClose(@origination,contactOrigination)
	end

	def new
		@origination = Origination.lumniStart(params,current_company, list: current_user.template('Origination','originations',current_user))
		contactOrigination = @origination.lumniSave(params,current_user, list: current_user.template('Origination','originations',current_user))
		lumniClose(@origination,contactOrigination)
	end

	def create
		@origination = Origination.lumniStart(params,current_company, list: current_user.template('Origination','originations',current_user))
		contactOrigination = @origination.lumniSave(params,current_user, list: current_user.template('Origination','originations',current_user))
		lumniClose(@origination,contactOrigination)
	end

	def edit
		@origination = Origination.lumniStart(params,current_company, list: current_user.template('Origination','originations',current_user))
		contactOrigination = @origination.lumniSave(params,current_user, list: current_user.template('Origination','originations',current_user))
		lumniClose(@origination,contactOrigination)
	end

	def update
		@origination = Origination.lumniStart(params,current_company, list: current_user.template('Origination','originations',current_user))
		contactOrigination = @origination.lumniSave(params,current_user, list: current_user.template('Origination','originations',current_user))
		lumniClose(@origination,contactOrigination)
	end
	def destroy
		@origination = Origination.lumniStart(params,current_company, list: current_user.template('Origination','originations',current_user))
		contactOrigination = @origination.lumniSave(params,current_user, list: current_user.template('Origination','originations',current_user))
		lumniClose(@cluster,contactOrigination)
	end

	def sort
		eval(params[:model]).update(params[:sort],(1..params[:sort].length).map{ |o |{order: o}})
	end

	def clone_origination
		params[:action] = 'new'
		@origination = Origination.lumniStart(params,current_company, list: current_user.template('Origination','originations',current_user))
		contactOrigination = @origination.lumniSave(params,current_user, list: current_user.template('Origination','originations',current_user))
		lumniClose(@origination,contactOrigination)
	end

	def create_clone_origination
		params[:action] = 'create'
		@origination = Origination.lumniStart(params,current_company, list: current_user.template('Origination','originations',current_user))
		contactOrigination = @origination.lumniSave(params,current_user, list: current_user.template('Origination','originations',current_user))

		original_origination = Origination.cached_find(params[:id])

		original_origination.origination_module.each do |o_module|
			new_module = o_module.dup
			new_module.origination_id = @origination.id
			new_module.save
			o_module.origination_section.each do |section|
				new_section = section.dup
				new_section.origination_module_id = new_module.id
				new_section.save
			end 
		end

		lumniClose(@origination,contactOrigination)

	end


end