class DefaultMatricesController < ApplicationController
	def index
		@default_matrix = DefaultMatrix.lumniStart(params,current_company, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		contactDefaultMatrix = @default_matrix.lumniSave(params,current_user, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		lumniClose(@default_matrix,contactDefaultMatrix)
	end

	def new
		@default_matrix = DefaultMatrix.lumniStart(params,current_company, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		@default_matrix.country_id = params[:country_id]
		contactDefaultMatrix = @default_matrix.lumniSave(params,current_user, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		lumniClose(@default_matrix,contactDefaultMatrix)
	end

	def create
		@default_matrix = DefaultMatrix.lumniStart(params,current_company, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		contactDefaultMatrix = @default_matrix.lumniSave(params,current_user, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		redirect_to edit_country_path(@default_matrix.country_id,anchor: 'default_matrix_tab')
	end

	def edit
		@default_matrix = DefaultMatrix.lumniStart(params,current_company, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		contactDefaultMatrix = @default_matrix.lumniSave(params,current_user, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		lumniClose(@default_matrix,contactDefaultMatrix)
	end

	def update
		@default_matrix = DefaultMatrix.lumniStart(params,current_company, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		contactDefaultMatrix = @default_matrix.lumniSave(params,current_user, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		redirect_to edit_country_path(@default_matrix.country_id,anchor: 'default_matrix_tab')
	end
	def destroy
		@default_matrix = DefaultMatrix.lumniStart(params,current_company, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		contactDefaultMatrix = @default_matrix.lumniSave(params,current_user, list: current_user.template('DefaultMatrix','default_matrices',current_user))
		lumniClose(@cluster,contactDefaultMatrix)
	end
end