class GenerateMatchesController < ApplicationController
	def index
		@generate_match = GenerateMatch.lumniStart(params,current_company, list: current_user.template('GenerateMatch','generate_matches',current_user))
		contactGenerateMatch = @generate_match.lumniSave(params,current_user, list: current_user.template('GenerateMatch','generate_matches',current_user))
		lumniClose(@generate_match,contactGenerateMatch)
	end

	def new
		@generate_match = GenerateMatch.lumniStart(params,current_company, list: current_user.template('GenerateMatch','generate_matches',current_user))
		contactGenerateMatch = @generate_match.lumniSave(params,current_user, list: current_user.template('GenerateMatch','generate_matches',current_user))
		lumniClose(@generate_match,contactGenerateMatch)
	end

	def create
		@generate_match = GenerateMatch.lumniStart(params,current_company, list: current_user.template('GenerateMatch','generate_matches',current_user))
		contactGenerateMatch = @generate_match.lumniSave(params,current_user, list: current_user.template('GenerateMatch','generate_matches',current_user))
		lumniClose(@generate_match,contactGenerateMatch)
	end

	def edit
		@generate_match = GenerateMatch.lumniStart(params,current_company, list: current_user.template('GenerateMatch','generate_matches',current_user))
		contactGenerateMatch = @generate_match.lumniSave(params,current_user, list: current_user.template('GenerateMatch','generate_matches',current_user))
		lumniClose(@generate_match,contactGenerateMatch)
	end

	def update
		@generate_match = GenerateMatch.lumniStart(params,current_company, list: current_user.template('GenerateMatch','generate_matches',current_user))
		contactGenerateMatch = @generate_match.lumniSave(params,current_user, list: current_user.template('GenerateMatch','generate_matches',current_user))
		lumniClose(@generate_match,contactGenerateMatch)
	end
	def destroy
		@generate_match = GenerateMatch.lumniStart(params,current_company, list: current_user.template('GenerateMatch','generate_matches',current_user))
		contactGenerateMatch = @generate_match.lumniSave(params,current_user, list: current_user.template('GenerateMatch','generate_matches',current_user))
		lumniClose(@cluster,contactGenerateMatch)
	end
end