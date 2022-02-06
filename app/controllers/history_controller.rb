class HistoryController < ApplicationController
	def index
		@target_record = eval(params[:object]).find(params[:target_id].to_i)
		@remote_params = params
		respond_to do |format|
			format.js 
		end
	end
end
