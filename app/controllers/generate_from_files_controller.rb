class GenerateFromFilesController < ApplicationController
	def index
		@generate_from_file = GenerateFromFile.lumniStart(params,current_company, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		contactGenerateFromFile = @generate_from_file.lumniSave(params,current_user, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		lumniClose(@generate_from_file,contactGenerateFromFile)
	end

	def new
		@generate_from_file = GenerateFromFile.lumniStart(params,current_company, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		contactGenerateFromFile = @generate_from_file.lumniSave(params,current_user, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		lumniClose(@generate_from_file,contactGenerateFromFile)
	end

	def create
		@generate_from_file = GenerateFromFile.lumniStart(params,current_company, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		contactGenerateFromFile = @generate_from_file.lumniSave(params,current_user, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		lumniClose(@generate_from_file,contactGenerateFromFile)
	end

	def edit
		@generate_from_file = GenerateFromFile.lumniStart(params,current_company, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		contactGenerateFromFile = @generate_from_file.lumniSave(params,current_user, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		lumniClose(@generate_from_file,contactGenerateFromFile)
	end

	def update
		@generate_from_file = GenerateFromFile.lumniStart(params,current_company, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		contactGenerateFromFile = @generate_from_file.lumniSave(params,current_user, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		lumniClose(@generate_from_file,contactGenerateFromFile)
	end
	def destroy
		@generate_from_file = GenerateFromFile.lumniStart(params,current_company, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		contactGenerateFromFile = @generate_from_file.lumniSave(params,current_user, list: current_user.template('GenerateFromFile','generate_from_files',current_user))
		lumniClose(@cluster,contactGenerateFromFile)
	end
end