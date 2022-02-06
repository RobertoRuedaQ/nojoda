class InvestmentDecisionsController < ApplicationController
	def index
		@investment_decision = InvestmentDecision.lumniStart(params,current_company, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		contactInvestmentDecision = @investment_decision.lumniSave(params,current_user, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		lumniClose(@investment_decision,contactInvestmentDecision)
	end

	def new
		@investment_decision = InvestmentDecision.lumniStart(params,current_company, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		contactInvestmentDecision = @investment_decision.lumniSave(params,current_user, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		lumniClose(@investment_decision,contactInvestmentDecision)
	end

	def create
		@investment_decision = InvestmentDecision.lumniStart(params,current_company, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		contactInvestmentDecision = @investment_decision.lumniSave(params,current_user, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		lumniClose(@investment_decision,contactInvestmentDecision)
	end

	def edit
		@investment_decision = InvestmentDecision.lumniStart(params,current_company, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		contactInvestmentDecision = @investment_decision.lumniSave(params,current_user, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		lumniClose(@investment_decision,contactInvestmentDecision)
	end

	def update
		@investment_decision = InvestmentDecision.lumniStart(params,current_company, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		contactInvestmentDecision = @investment_decision.lumniSave(params,current_user, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		lumniClose(@investment_decision,contactInvestmentDecision)
	end
	def destroy
		@investment_decision = InvestmentDecision.lumniStart(params,current_company, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		contactInvestmentDecision = @investment_decision.lumniSave(params,current_user, list: current_user.template('InvestmentDecision','investment_decisions',current_user))
		lumniClose(@cluster,contactInvestmentDecision)
	end
end