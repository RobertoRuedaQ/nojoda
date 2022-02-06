class GeographiesController < ApplicationController
	def index
		@geography = Geography.lumniStart(params,current_company, list: current_user.template('Geography','geographies',current_user))
		contactGeography = @geography.lumniSave(params,current_user, list: current_user.template('Geography','geographies',current_user))
		lumniClose(@geography,contactGeography)
	end

	def new
		@geography = Geography.lumniStart(params,current_company, list: current_user.template('Geography','geographies',current_user))
		contactGeography = @geography.lumniSave(params,current_user, list: current_user.template('Geography','geographies',current_user))
		lumniClose(@geography,contactGeography)
	end

	def create
		@geography = Geography.lumniStart(params,current_company, list: current_user.template('Geography','geographies',current_user))
		contactGeography = @geography.lumniSave(params,current_user, list: current_user.template('Geography','geographies',current_user))
		lumniClose(@geography,contactGeography)
	end

	def edit
		@geography = Geography.lumniStart(params,current_company, list: current_user.template('Geography','geographies',current_user))
		contactGeography = @geography.lumniSave(params,current_user, list: current_user.template('Geography','geographies',current_user))
		lumniClose(@geography,contactGeography)
	end

	def update
		@geography = Geography.lumniStart(params,current_company, list: current_user.template('Geography','geographies',current_user))
		contactGeography = @geography.lumniSave(params,current_user, list: current_user.template('Geography','geographies',current_user))
		lumniClose(@geography,contactGeography)
	end
	def destroy
		@geography = Geography.lumniStart(params,current_company, list: current_user.template('Geography','geographies',current_user))
		contactGeography = @geography.lumniSave(params,current_user, list: current_user.template('Geography','geographies',current_user))
		lumniClose(@cluster,contactGeography)
	end
end