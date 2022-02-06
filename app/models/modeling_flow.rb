class ModelingFlow < ApplicationRecord
      
      resourcify
      audited
  belongs_to :modeling
  belongs_to :funding_option
  belongs_to :valuation_history, optional: true, touch: true
  has_many :modeling_flow_detail, dependent: :destroy
  has_many :modeling_flow_summary, dependent: :destroy

  validates :valuation_history_id, uniqueness: {scope: :funding_option_id}

  before_create :validate_dates

  def validate_dates
    if self.month.nil?
      self.month = (Time.now - 1.month).month
    end
    if self.year.nil?
      self.year = (Time.now - 1.month).year
    end
  end

  def self.storing_modeling_info modeling_info, valuation_history_id=nil
    target_case = modeling_info['case'].first
    target_funding_option = modeling_info['funding_option'].first
    funding_option_id = target_funding_option['id']

    case target_case
    when 'modeling'
      year = Time.now.year
      month = Time.now.month
    end

    funding_option = FundingOption.joins(modeling_fixed_condition: :modeling).find(funding_option_id)
    flow = ModelingFlow.new(year: year, 
                month: month, 
                flow_case: modeling_info['case'].first, 
                funding_option_id: target_funding_option['id'],
                modeling_id: funding_option.modeling.id,
                valuation_history_id: valuation_history_id)
    if flow.save
      flow.create_cashflow( modeling_info['cashflows'])
      flow.create_summary( modeling_info['summary_table'])

      #updating funding option
      if target_case == 'modeling'
        modeling_rate = modeling_info['summary_table'].last['retorno']
        target_rate = funding_option.modeling.target_rate.to_f / 100
        if modeling_rate.present? && (modeling_rate - target_rate).abs < 0.01 || 
          (modeling_info['cashflows'].last.present? && modeling_info['cashflows'].last["cumulative_pv_target_flow"] > 0) || 
          modeling_info['summary_table'].last['algorithm'] == 'searching_percentaje' ||
          (modeling_info['cashflows'].last.present? && modeling_info['cashflows'].last["cumulative_pv_target_flow"] < 0 && modeling_info['cashflows'].last.present? && modeling_info['disbursement'].last.present? && modeling_info['cashflows'].last["cumulative_pv_target_flow"].abs.to_f / modeling_info['disbursement'].map{|d| d['student_value']}.inject(:+) <= 0.01) ||
          (modeling_info['force_validation'].present? && modeling_info['force_validation'].first == true)
          modeling_result = 'done'
        else
          modeling_result = 'failed'
        end

        modeling_validation = 
        funding_option.update({ percentage_graduated: (target_funding_option['percentage_graduated'].to_f * 100).round(1),
                                percentage_student: (target_funding_option['percentage_student'].to_f * 100).round(1),
                                isa_term: target_funding_option['isa_term'],
                                model_status: modeling_result
                              })

        #updating disbursements
        modeling_info['disbursement'].each do |disbursement| 
          Disbursement.find(disbursement['id']).update( student_value: disbursement['student_value'],
                                                      company_value: disbursement['company_value'])
        end
      end
    end
  end

  def create_summary target_info
    ModelingFlowSummary.where(modeling_flow_id: self.id).destroy_all
    target_keys = ModelingFlowSummary.attribute_names & target_info.first.keys
    target_info.each do |summary_row|
      temp_summary_row = ModelingFlowSummary.new({modeling_flow_id: self.id})
      target_keys.map{|key| temp_summary_row[key.to_sym] =  summary_row[key]}
      temp_summary_row.save
    end
  end


  def create_cashflow target_info
    ModelingFlowDetail.where(modeling_flow_id: self.id).destroy_all
    target_info.each do |flow_detail|
      detail = ModelingFlowDetail.new({modeling_flow_id: self.id, 
                        student_flow: flow_detail['student_flow'], 
                        fund_flow: flow_detail['fund_flow'], 
                        investor_flow: flow_detail['investor_flow'], 
                        modeling_date: flow_detail['dates'], 
                        default_probability: flow_detail['default_probability'], 
                        unemployent_probability: flow_detail['unemploymet_probability'], 
                        cap_value: flow_detail['insurance_vector']})

      if detail.save

        extra_keys = flow_detail.keys & ModelingFlowExtra.attribute_names
        extra_info = ModelingFlowExtra.new(modeling_flow_detail_id: detail.id)
        extra_keys.map{|extra| extra_info[extra.to_sym] = flow_detail[extra]}
        extra_info.save


        fee_count = flow_detail.keys.select{|f| f.include?('id_fee_')}.count

        (1..fee_count).each do |f|
          ModelingFlowFee.create({detail_fee: flow_detail["detail_fee_#{f}"], tax: flow_detail["tax_#{f}"], modeling_fee_id: flow_detail["id_fee_#{f}"], modeling_flow_detail_id:  detail.id})
        end

      end
    end
  end

end
