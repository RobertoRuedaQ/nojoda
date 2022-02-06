class HomeController < ApplicationController
  layout 'main/layout-without-sidenav'
  def index
    @title = 'Home'
    @restricted_companies_for_log_in = [21,2,7]


    if user_signed_in?
    	redirect_to mains_path
    end
  end

  def edit
  end

  def update
    cookies[:language] = params[:id]
    I18n.locale = cookies[:language]
    redirect_back(fallback_location: root_path )
  end

end
