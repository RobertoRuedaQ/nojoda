class SearchersController < ApplicationController
	def index
		filtering = filter_interactor
		@ransack = filtering.ransack
		@users = filtering.result.limit(300)
	end

	def new
		@searcher = Searcher.lumniStart(params,current_company, list: current_user.template('Searcher','searchers',current_user))
		contactSearcher = @searcher.lumniSave(params,current_user, list: current_user.template('Searcher','searchers',current_user))
		lumniClose(@searcher,contactSearcher)
	end

	def create
		@searcher = Searcher.find_by(user_id: params[:searcher][:user_id],value: params[:searcher][:value])
		if @searcher.nil?
			@searcher = Searcher.create(params_for_search)
		end
		redirect_to @searcher

		# contactSearcher = @searcher.lumniSave(params,current_user, list: current_user.template('Searcher','searchers',current_user))
		# lumniClose(@searcher,contactSearcher)
	end

	def edit
		@searcher = Searcher.find(params[:id])
		@identification_number = User.joins(:personal_information).where('personal_informations.identification_number LIKE ?',"%#{@searcher.value}%").map{|u| u}
		@bank_account = User.joins(:bank_account).where('bank_accounts.account_number LIKE ?',"%#{@searcher.value}%").map{|u| u}


		# @searcher = Searcher.lumniStart(params,current_company, list: current_user.template('Searcher','searchers',current_user))
		# contactSearcher = @searcher.lumniSave(params,current_user, list: current_user.template('Searcher','searchers',current_user))
		# lumniClose(@searcher,contactSearcher)
	end

	def update
		@searcher = Searcher.lumniStart(params,current_company, list: current_user.template('Searcher','searchers',current_user))
		contactSearcher = @searcher.lumniSave(params,current_user, list: current_user.template('Searcher','searchers',current_user))
		lumniClose(@searcher,contactSearcher)
	end
	def destroy
		@searcher = Searcher.lumniStart(params,current_company, list: current_user.template('Searcher','searchers',current_user))
		contactSearcher = @searcher.lumniSave(params,current_user, list: current_user.template('Searcher','searchers',current_user))
		lumniClose(@cluster,contactSearcher)
	end

	def show
		@searcher = Searcher.find(params[:id])
		@users = User.where(company_id: current_company.my_companies.ids).searcher(@searcher.value)
	end



	private
		def params_for_search
			params.require(:searcher).permit(:user_id,:value)
		end

		def filter_interactor
			FilterInteractor.call(
				resource: Student.lumniStart(params, current_company).includes(:contact_info),
				params: params
			)
		end
end