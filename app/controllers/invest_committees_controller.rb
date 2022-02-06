class InvestCommitteesController < ApplicationController
	def index
		@invest_committee = InvestCommittee.lumniStart(params,current_company, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		contactInvestCommittee = @invest_committee.lumniSave(params,current_user, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		lumniClose(@invest_committee,contactInvestCommittee)
	end

	def new
		@invest_committee = InvestCommittee.lumniStart(params,current_company, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		@invest_committee.company_id = current_company.id
		contactInvestCommittee = @invest_committee.lumniSave(params,current_user, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		lumniClose(@invest_committee,contactInvestCommittee)
	end

	def create
		@invest_committee = InvestCommittee.lumniStart(params,current_company, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		contactInvestCommittee = @invest_committee.lumniSave(params,current_user, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		lumniClose(@invest_committee,contactInvestCommittee)
	end

	def edit
		@invest_committee = InvestCommittee.includes(:pending_changes).lumniStart(params,current_company, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		contactInvestCommittee = @invest_committee.lumniSave(params,current_user, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		lumniClose(@invest_committee,contactInvestCommittee)
	end

	def update
		@invest_committee = InvestCommittee.lumniStart(params,current_company, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		contactInvestCommittee = @invest_committee.lumniSave(params,current_user, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		lumniClose(@invest_committee,contactInvestCommittee)
	end
	def destroy
		@invest_committee = InvestCommittee.lumniStart(params,current_company, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		contactInvestCommittee = @invest_committee.lumniSave(params,current_user, list: current_user.template('InvestCommittee','invest_committees',current_user,current_company: current_company))
		lumniClose(@cluster,contactInvestCommittee)
	end

	def approve
		funding_option = FundingOption.find(params[:funding_option_id])
		funding_opportunity = funding_option.funding_opportunity
		user = funding_option.user
		take_decision 'approved'
		if @legal_match.present?
			Isa.create({
				funding_opportunity_id:@legal_match.resource.application.funding_opportunity.id ,
				user_id: @legal_match.user_id, status: 'active', start_date: Time.now.to_date,
				funding_option_id: @legal_match.resource_id,
				inflation_adjustment_date: Time.now.to_date,
				currency: @legal_match.application.funding_opportunity.fund.company.country.currency,
				funding_opportunity_id: @legal_match.application.resource_id, 
				student_academic_information_id: @legal_match.application.funded_major.id} )
		end

		if funding_opportunity.bootcamp == true && user.active_isa.any?
			PerformServiceAsync.perform_async('ActivateBootcampStudentService', user.id)
		end

	end


	def reject
		take_decision 'rejected'
	end

	def application_committee
		@invest_committee = InvestCommittee.includes(:pending_changes).find(params[:id])
		@users_to_review = User.includes(:pending_changes).to_application_committee(@invest_committee.funding_opportunity_id).user_questionnaire_committee.distinct
	end

	def invest_decision
		@invest_committee = InvestCommittee.includes(:pending_changes).find(params[:id])
		@pending_contracts = current_company.my_companies.contracts_to_approve.where(resource_type: 'FundingOpportunity', resource_id: @invest_committee.funding_opportunity_id).distinct.paginate(page: params[:page], per_page: 10)
	end


	private
	def take_decision target_status
		investment_decision = InvestmentDecision.new({invest_committee_id: params[:id],funding_option_id: params[:funding_option_id],user_id: params[:user_id],status: target_status})

		if investment_decision.save
			@legal_match = LegalMatch.find_by(resource_type: 'FundingOption',resource_id: params[:funding_option_id])
			@legal_match.update(status: target_status)
			application = @legal_match.application
			application.update({status: target_status})
			
		end

	end
end