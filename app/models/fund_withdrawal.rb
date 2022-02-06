class FundWithdrawal < ApplicationRecord
  belongs_to :isa
  has_many_attached :fund_withdrawal_support
  after_update :complete_process_fund_withdrawal

  def origination
    self.isa.funding_opportunity.fund.fund_withdrawal_origination
  end

  def complete_process_fund_withdrawal
    PerformServiceAsync.perform_async('WithdralFromFundService', self.isa_id)
  end
end
