class BankAccount < ApplicationRecord
      
      resourcify
      audited
	belongs_to :resource, polymorphic: true,touch: true
	belongs_to :user, ->{joins(:all_bank_accounts).where(bank_accounts: {resource_type: 'User'})},class_name: 'User',foreign_key: 'resource_id', optional: true


	has_many_attached :bank_certification

	after_update :set_uniq_active_account

	def cached_name
		Rails.cache.fetch(['bank_account_name', self.id]){account_label}
	end

	def final_name
		self.resource_type == 'User' ? self.name : self.resource.name
	end


	def account_label
		if self.resource_type == 'User'
			self.account_number.to_s + ' - ' + self.bank_name.to_s + ' - ' + self.final_name.to_s
		else 
			self.account_number.to_s + ' - ' + self.bank_name.to_s + ' - ' + self.resource.name.to_s
		end
	end

  def origination
    self.resource.funding_opportunities.last.fund.bank_account_origination
  end

	def set_uniq_active_account
		bank_accounts = BankAccount.where(resource_id: self.resource_id, resource_type: 'User').where.not(id: self.id)
		bank_accounts.each{|bank_account| bank_account.update_column('active', false)}
		self.update_column('active', true)
	end

end
