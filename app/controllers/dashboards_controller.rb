class DashboardsController < ApplicationController
include LumniDashboards

	def index
		@dashboard = Dashboard.lumniStart(params,current_company, list: current_user.template('Dashboard','dashboards',current_user))
		contactDashboard = @dashboard.lumniSave(params,current_user, list: current_user.template('Dashboard','dashboards',current_user))
		lumniClose(@dashboard,contactDashboard)
	end

	def new
		@dashboard = Dashboard.lumniStart(params,current_company, list: current_user.template('Dashboard','dashboards',current_user))
		contactDashboard = @dashboard.lumniSave(params,current_user, list: current_user.template('Dashboard','dashboards',current_user))
		lumniClose(@dashboard,contactDashboard)
	end

	def create
		@dashboard = Dashboard.lumniStart(params,current_company, list: current_user.template('Dashboard','dashboards',current_user))
		contactDashboard = @dashboard.lumniSave(params,current_user, list: current_user.template('Dashboard','dashboards',current_user))
		lumniClose(@dashboard,contactDashboard)
	end

	def edit
		@dashboard = Dashboard.lumniStart(params,current_company, list: current_user.template('Dashboard','dashboards',current_user))
		eval("#{@dashboard.fixed_report}(params)")
	end

	def update
		@dashboard = Dashboard.lumniStart(params,current_company, list: current_user.template('Dashboard','dashboards',current_user))
		contactDashboard = @dashboard.lumniSave(params,current_user, list: current_user.template('Dashboard','dashboards',current_user))
		lumniClose(@dashboard,contactDashboard)
	end

	def destroy
		@dashboard = Dashboard.lumniStart(params,current_company, list: current_user.template('Dashboard','dashboards',current_user))
		contactDashboard = @dashboard.lumniSave(params,current_user, list: current_user.template('Dashboard','dashboards',current_user))
		lumniClose(@cluster,contactDashboard)
	end
end