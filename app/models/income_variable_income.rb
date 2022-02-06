class IncomeVariableIncome < ApplicationRecord
      
      resourcify
      audited
  belongs_to :income_information
  belongs_to :billing_document
  after_commit :refresh_billing_document

    has_one_attached :support


  def refresh_billing_document
  	self.billing_document.refresh
  end


end
