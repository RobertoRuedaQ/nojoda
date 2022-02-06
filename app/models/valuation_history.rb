class ValuationHistory < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
  belongs_to :fund
  has_many :modeling_flows, dependent: :destroy
  has_many :valuation_details, dependent: :destroy

  after_create :run_valuation
  after_touch :condense_results

  def run_valuation
  	self.valuate_fund
  end


  def valuate_fund
      if Rails.env == 'production'
        ModelClassesAsync.perform_async('ValuationHistory', 'valuation_process', self.id)
      else
        self.valuation_process
      end
  end

  def valuation_process
    self.fund.total_funding_options(self.id).each do |funding_option|
      if Rails.env == 'production'
        sleep(20)
        ValuateSingleOptionAsync.perform_async(funding_option.id, self.id)
      else
        funding_option.model_with_r self.id
      end
    end
  end


  def condense_results

    if self.status != 'done' && self.expected_records == self.modeling_flows.count 
      self.update_column('status','done')

      student_flow = ModelingFlowDetail.where(modeling_flow_id: self.modeling_flows.ids).group(:modeling_date).sum(:student_flow)
      fund_flow = ModelingFlowDetail.where(modeling_flow_id: self.modeling_flows.ids).group(:modeling_date).sum(:fund_flow)
      investor_flow = ModelingFlowDetail.where(modeling_flow_id: self.modeling_flows.ids).group(:modeling_date).sum(:investor_flow)

      student_flow.each do |target_date, student_value|
        target_detail = ValuationDetail.find_or_create_by({date: target_date, valuation_history_id: self.id})
        target_detail.update_column('student_flow', student_value)
      end

      fund_flow.each do |target_date, fund_value|
        target_detail = ValuationDetail.find_or_create_by({date: target_date, valuation_history_id: self.id})
        target_detail.update_column('fund_flow', fund_value)
      end

      investor_flow.each do |target_date, investor_value|
        target_detail = ValuationDetail.find_or_create_by({date: target_date, valuation_history_id: self.id})
        target_detail.update_column('investor_flow', investor_value)
      end

    end

  end


end
