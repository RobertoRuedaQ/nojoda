class BizdevBusinessesController < ApplicationController
	def index
		@bizdev_business = BizdevBusiness.lumniStart(params,current_company, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user)).visible(current_user.id)
		contactBizdevBusiness = @bizdev_business.lumniSave(params,current_user, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user))
		lumniClose(@bizdev_business,contactBizdevBusiness)

		columns = ['name','leader_id','coleader_id','country','phase','general_status','priority', 'expected_closing_date','expected_revenue','expected_cf','expected_risk']
		@header = columns.map{|c| BizdevBusiness.human_attribute_name(c)}


	end

	def new
		@bizdev_business = BizdevBusiness.lumniStart(params,current_company, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user))
		contactBizdevBusiness = @bizdev_business.lumniSave(params,current_user, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user))
		lumniClose(@bizdev_business,contactBizdevBusiness)
	end

	def create
		@bizdev_business = BizdevBusiness.lumniStart(params,current_company, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user))
		@bizdev_business.created_by_id = current_user.id
		contactBizdevBusiness = @bizdev_business.lumniSave(params,current_user, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user))
		lumniClose(@bizdev_business,contactBizdevBusiness)
	end

	def edit
		@bizdev_business = BizdevBusiness.lumniStart(params,current_company, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user))
		belongs = @bizdev_business.project.project_team.map{|p| p.user_id}.include?(current_user.id)
		if belongs
			contactBizdevBusiness = @bizdev_business.lumniSave(params,current_user, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user))
		else
			contactBizdevBusiness = 'unauthorized'
		end
		lumniClose(@bizdev_business,contactBizdevBusiness)
	end

	def update
		@bizdev_business = BizdevBusiness.lumniStart(params,current_company, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user))
		contactBizdevBusiness = @bizdev_business.lumniSave(params,current_user, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user))
		lumniClose(@bizdev_business,contactBizdevBusiness)
	end
	def destroy
		@bizdev_business = BizdevBusiness.lumniStart(params,current_company, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user))
		contactBizdevBusiness = @bizdev_business.lumniSave(params,current_user, list: current_user.template('BizdevBusiness','bizdev_businesses',current_user))
		lumniClose(@cluster,contactBizdevBusiness)
	end
	def create_team
		params[:member].each do |member|
			@team_team = ProjectTeam.create({project_id: params[:teams],user_id: member})
		end
	end

	def destroy_team
		params[:member].each do |member|
			@team_team = ProjectTeam.where(project_id: params[:teams],user_id: member).cached_destroy_all
		end
	end

	def new_opportunity

	end
end