class ProjectFavoritesController < ApplicationController
	def index
		@project_favorite = ProjectFavorite.lumniStart(params,current_company, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		contactProjectFavorite = @project_favorite.lumniSave(params,current_user, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		lumniClose(@project_favorite,contactProjectFavorite)
	end

	def new
		@project_favorite = ProjectFavorite.lumniStart(params,current_company, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		contactProjectFavorite = @project_favorite.lumniSave(params,current_user, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		lumniClose(@project_favorite,contactProjectFavorite)
	end

	def create
		@project_favorite = ProjectFavorite.lumniStart(params,current_company, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		contactProjectFavorite = @project_favorite.lumniSave(params,current_user, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		lumniClose(@project_favorite,contactProjectFavorite)
	end

	def edit
		@project_favorite = ProjectFavorite.lumniStart(params,current_company, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		contactProjectFavorite = @project_favorite.lumniSave(params,current_user, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		lumniClose(@project_favorite,contactProjectFavorite)
	end

	def update
		@project_favorite = ProjectFavorite.lumniStart(params,current_company, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		contactProjectFavorite = @project_favorite.lumniSave(params,current_user, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		lumniClose(@project_favorite,contactProjectFavorite)
	end
	def destroy
		@project_favorite = ProjectFavorite.lumniStart(params,current_company, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		contactProjectFavorite = @project_favorite.lumniSave(params,current_user, list: current_user.template('ProjectFavorite','project_favorites',current_user))
		lumniClose(@cluster,contactProjectFavorite)
	end
end