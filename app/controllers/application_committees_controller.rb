class ApplicationCommitteesController < ApplicationController
	def index
		@application_committee = ApplicationCommittee.lumniStart(params,current_company, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		contactApplicationCommittee = @application_committee.lumniSave(params,current_user, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		lumniClose(@application_committee,contactApplicationCommittee)
	end

	def new
		@application_committee = ApplicationCommittee.lumniStart(params,current_company, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		contactApplicationCommittee = @application_committee.lumniSave(params,current_user, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		lumniClose(@application_committee,contactApplicationCommittee)
	end

	def create
		@application_committee = ApplicationCommittee.lumniStart(params,current_company, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		contactApplicationCommittee = @application_committee.lumniSave(params,current_user, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		lumniClose(@application_committee,contactApplicationCommittee)
	end

	def edit
		@application_committee = ApplicationCommittee.lumniStart(params,current_company, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		contactApplicationCommittee = @application_committee.lumniSave(params,current_user, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		lumniClose(@application_committee,contactApplicationCommittee)
	end

	def update
		@application_committee = ApplicationCommittee.lumniStart(params,current_company, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		contactApplicationCommittee = @application_committee.lumniSave(params,current_user, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		lumniClose(@application_committee,contactApplicationCommittee)
	end
	def destroy
		@application_committee = ApplicationCommittee.lumniStart(params,current_company, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		contactApplicationCommittee = @application_committee.lumniSave(params,current_user, list: current_user.template('ApplicationCommittee','application_committees',current_user))
		lumniClose(@cluster,contactApplicationCommittee)
	end
end