class CancellationConfigsController < ApplicationController
	def index
		@cancellation_config = CancellationConfig.lumniStart(params,current_company, list: current_user.template('CancellationConfig','cancellation_configs',current_user))
		contactCancellationConfig = @cancellation_config.lumniSave(params,current_user, list: current_user.template('CancellationConfig','cancellation_configs',current_user))
		lumniClose(@cancellation_config,contactCancellationConfig)
	end

	def new
		@cancellation_config = CancellationConfig.lumniStart(params,current_company, list: current_user.template('CancellationConfig','cancellation_configs',current_user))
		@cancellation_config.fund_id = params[:fund_id]
		contactCancellationConfig = @cancellation_config.lumniSave(params,current_user, list: current_user.template('CancellationConfig','cancellation_configs',current_user))
	end

	def create
		@cancellation_config = CancellationConfig.lumniStart(params,current_company, list: current_user.template('CancellationConfig','cancellation_configs',current_user))
		@cancellation_config.fund_id = params[:fund_id]
		if @cancellation_config.save
			flash[:success] = I18n.t('flash.record_approved')
			redirect_to edit_fund_path(params[:fund_id]) and return
		else
			flash[:danger] = I18n.t('flash.record_failed')
		end
	end

	def edit
		@cancellation_config = CancellationConfig.lumniStart(params,current_company, list: current_user.template('CancellationConfig','cancellation_configs',current_user))
		contactCancellationConfig = @cancellation_config.lumniSave(params,current_user, list: current_user.template('CancellationConfig','cancellation_configs',current_user))
		lumniClose(@cancellation_config,contactCancellationConfig)
	end

	def update
		@cancellation_config = CancellationConfig.lumniStart(params,current_company, list: current_user.template('CancellationConfig','cancellation_configs',current_user))
		contactCancellationConfig = @cancellation_config.lumniSave(params,current_user, list: current_user.template('CancellationConfig','cancellation_configs',current_user))
		lumniClose(@cancellation_config,contactCancellationConfig)
	end
	def destroy
		@cancellation_config = CancellationConfig.lumniStart(params,current_company, list: current_user.template('CancellationConfig','cancellation_configs',current_user))
		contactCancellationConfig = @cancellation_config.lumniSave(params,current_user, list: current_user.template('CancellationConfig','cancellation_configs',current_user))
		lumniClose(@cluster,contactCancellationConfig)
	end


end