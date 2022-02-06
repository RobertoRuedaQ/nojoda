class PlatziInformationController < ApplicationController
  layout 'errors'
  skip_before_action :authenticate_user!
  
	def index; end
end