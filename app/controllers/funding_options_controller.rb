class FundingOptionsController < ApplicationController
	def index
		@funding_option = FundingOption.lumniStart(params,current_company, list: current_user.template('FundingOption','funding_options',current_user))
		contactFundingOption = @funding_option.lumniSave(params,current_user, list: current_user.template('FundingOption','funding_options',current_user))
		lumniClose(@funding_option,contactFundingOption)
	end

	def new
		@funding_option = FundingOption.lumniStart(params,current_company, list: current_user.template('FundingOption','funding_options',current_user))
		contactFundingOption = @funding_option.lumniSave(params,current_user, list: current_user.template('FundingOption','funding_options',current_user))
		lumniClose(@funding_option,contactFundingOption)
	end

	def create
		@funding_option = FundingOption.lumniStart(params,current_company, list: current_user.template('FundingOption','funding_options',current_user))
		contactFundingOption = @funding_option.lumniSave(params,current_user, list: current_user.template('FundingOption','funding_options',current_user))
		lumniClose(@funding_option,contactFundingOption)
	end

	def edit
		@funding_option = FundingOption.lumniStart(params,current_company, list: current_user.template('FundingOption','funding_options',current_user))
		contactFundingOption = @funding_option.lumniSave(params,current_user, list: current_user.template('FundingOption','funding_options',current_user))
		lumniClose(@funding_option,contactFundingOption)
	end

	def update
		@funding_option = FundingOption.lumniStart(params,current_company, list: current_user.template('FundingOption','funding_options',current_user))
		contactFundingOption = @funding_option.lumniSave(params,current_user, list: current_user.template('FundingOption','funding_options',current_user))
		lumniClose(@funding_option,contactFundingOption)
	end
	def destroy
		@funding_option = FundingOption.lumniStart(params,current_company, list: current_user.template('FundingOption','funding_options',current_user))
		contactFundingOption = @funding_option.lumniSave(params,current_user, list: current_user.template('FundingOption','funding_options',current_user))
		lumniClose(@cluster,contactFundingOption)
	end

	def changes_visibility
		@funding_options = FundingOption.cached_find(params[:id])
		@funding_options.update(visible_to_student: params[:value])
	end


	def export_modeling_to_r
		@funding_options = FundingOption.cached_find(params[:id])

		respond_to do |format|
			format.js {render :json => @funding_options.get_adjusted_modeling_data.to_json}
		end
	end

	def update_cap_value
		@funding_option = FundingOption.cached_find(params[:id])
		if @funding_option
			UpdateValueToCapService.for(@funding_option, Time.now.to_date)
		end

		redirect_back(fallback_location: root_path)
	end
end