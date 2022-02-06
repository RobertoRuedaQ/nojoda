module FundingOpportunityHelper
	def create_funding_token_table target_tokens
		header = [FundingToken.human_attribute_name('token'),FundingToken.human_attribute_name('token_status'),FundingToken.human_attribute_name('name'),FundingToken.human_attribute_name('target_email'),FundingToken.human_attribute_name('email_sent'), I18n.t('general.actions')]
		rows = target_tokens.map{|t| [t.token,I18n.t("form.#{t.token_status}"),t.name,t.target_email,t.email_sent, link_to(I18n.t('general.destroy'), funding_token_path(t),method: :delete,class: 'text-danger',remote: true)]}
		render '/funding_opportunities/partial/token', header: header, rows: rows
	end
	def create_funding_invitation_table invitations
		header = [FundingOpportunityInvitation.human_attribute_name('name'),FundingOpportunityInvitation.human_attribute_name('target_email')]
		rows = invitations.map{|t| [t.name,t.target_email]}
		render '/funding_opportunities/partial/invitation', header: header, rows: rows
	end

	def future_income_text_for(fund)
		fund.id == 614 ? I18n.t('students.future_income_uwc') : I18n.t('students.future_income')
	end
end
