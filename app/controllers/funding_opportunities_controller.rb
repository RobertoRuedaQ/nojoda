class FundingOpportunitiesController < ApplicationController

	def index
		@funding_opportunity = FundingOpportunity.full_funding_opportunity.lumniStart(params,current_company,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company)).from_country(helpers.my_companies.ids)
		fundingOpportunityResult = @funding_opportunity.lumniSave(params,current_user,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		lumniClose(@funding_opportunity,fundingOpportunityResult,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
	end

	def new
		@funding_opportunity = FundingOpportunity.full_funding_opportunity.lumniStart(params,current_company,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		fundingOpportunityResult = @funding_opportunity.lumniSave(params,current_user,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		lumniClose(@funding_opportunity,fundingOpportunityResult,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
	end

	def create
		@funding_opportunity = FundingOpportunity.full_funding_opportunity.lumniStart(params,current_company,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		fundingOpportunityResult = @funding_opportunity.lumniSave(params,current_user,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		lumniClose(@funding_opportunity,fundingOpportunityResult,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
	end

	def edit
		@funding_opportunity = FundingOpportunity.includes(:funding_disbursement,:funding_opportunity_team).lumniStart(params,current_company,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		fundingOpportunityResult = @funding_opportunity.lumniSave(params,current_user,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		lumniClose(@funding_opportunity,fundingOpportunityResult,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		students_with_contract_ids = Application.where(resource_type: "FundingOpportunity", resource_id: @funding_opportunity.id).pluck(:user_id)

		@students_with_contract = User.joins(:legal_match).where(id: students_with_contract_ids).where(legal_matches: {legal_document_id: [@funding_opportunity.contract_adult_id,@funding_opportunity.contract_young_id,@funding_opportunity.amendment_adult_id,@funding_opportunity.amendment_young_id]})
	end

	def update
		@funding_opportunity = FundingOpportunity.full_funding_opportunity.lumniStart(params,current_company,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		fundingOpportunityResult = @funding_opportunity.lumniSave(params,current_user,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		lumniClose(@funding_opportunity,fundingOpportunityResult,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
	end
	def destroy
		@funding_opportunity = FundingOpportunity.full_funding_opportunity.lumniStart(params,current_company,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		fundingOpportunityResult = @funding_opportunity.lumniSave(params,current_user,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		lumniClose(@cluster,fundingOpportunityResult,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
	end

	def clone_funding_opportunity

		params[:action] = 'edit'
		@funding_opportunity = FundingOpportunity.find(params[:id])
		@funding_opportunity.name = nil
		fundingOpportunityResult = @funding_opportunity.lumniSave(params,current_user,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		lumniClose(@funding_opportunity,fundingOpportunityResult,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))

	end 

	def create_clone_funding_opportunity
		params[:action] = 'create'
		@funding_opportunity = FundingOpportunity.full_funding_opportunity.lumniStart(params,current_company,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		fundingOpportunityResult = @funding_opportunity.lumniSave(params,current_user,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
		unless @funding_opportunity.id.nil?
			original_funding_opportunity = FundingOpportunity.find(params[:id])
			['funding_disbursement','payment_config','disbursement_origination','academi_origination','process_origination'].each do |single_record|
				@funding_opportunity.send(single_record).update_attributes(original_funding_opportunity.send(single_record).hash_to_clone('funding_opportunity_id'))
			end

		end
		lumniClose(@funding_opportunity,fundingOpportunityResult,list: current_user.template('FundingOpportunity','funding_opportunities',current_user,current_company: current_company))
	end

end
