class ModelingFee < ApplicationRecord
      
      resourcify
      audited
  belongs_to :modeling

  scope :to_model, -> {where(include_in_modeling: true)}


  def unique_date_value funding_option
    general_date_transalte self.value_fee_unique_date_field, funding_option
  end


  def general_date_transalte target_evaluation, funding_option
    result = 0
    case target_evaluation
    when 'fund_limit_date'
      result = funding_option.fund.close_date
    when 'agreed_design_fee_date'
      result = funding_option.fund.start_date
    when 'selection_test_date'
      result =  if funding_option.selection_test_date.nil?
                  funding_option.first_disbursement_date
                else
                  funding_option.selection_test_date.to_date
                end
    when 'contract_send_date'
      result = funding_option.activation_date.to_date
    when 'diploma_delivery_date'
      result = funding_option.user.funded_academic_information.diploma_delivery_date
      if result.nil?
        result = funding_option.user.funded_academic_information.expected_diploma_delivery_date
        if result.nil?
          result = funding_option.user.funded_academic_information.graduation_date
          if result.nil?
            result = funding_option.start_repayment_date
          end
        end
      end
    when 'start_date'
      result = funding_option.fund.start_date
    when 'start_repayment_date'
      result = funding_option.start_repayment_date
    when 'first_disbursement_date'
      result = funding_option.first_disbursement_date
    when 'activation_date'
      result = funding_option.fund.activation_date
    when 'out_of_the_fund_date'
      result = funding_option.regular_exit_from_fond_date
    end

    if result != 0
      result = result.beginning_of_month
    end
    return result
  end

  def start_date funding_option
    if self.fee_case == "single_payment"
      target_evaluation = self.value_fee_unique_date_field
    else
      target_evaluation = self.value_fee_start_fee_field
    end
    general_date_transalte target_evaluation, funding_option
  end

  def end_date funding_option
    if self.fee_case == "single_payment"
      target_evaluation = self.value_fee_unique_date_field
    else
      target_evaluation = self.value_fee_end_fee_field
    end
    general_date_transalte target_evaluation, funding_option
  end

  

end
