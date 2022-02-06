class UpdateRateCapService

  def self.for(params)
    new(params).perform
  end

  def initialize(params)
    @rate_cap_value = params['rate_cap_value']
    @country = params['country']
  end


  def perform
    begin
      update_rate_cap
      update_payment_config
    rescue StandardError => e
      return puts e
    end
  end

  private
  
  def call_funding_options_by_country
    FundingOption.by_country(@country).merge(FundingOption.funding_options_with_dynamic_rate)
  end

  def funding_options_ids
    call_funding_options_by_country.pluck(:id)
  end

  def update_rate_cap
    FundingOption.where(id: funding_options_ids ).each do |fo|
      if fo.top_rate_cap != false
        top_rate_cap = fo.top_rate_cap
        funding_option_config_rate_cap = fo.funding_option_config.select{|foc| foc.name == 'rate_cap'}.last
        if fo.isa.present? && funding_option_config_rate_cap.present? && top_rate_cap > @rate_cap_value
          UpdateAsync.perform_async('funding_option_config', funding_option_config_rate_cap.id ,value: @rate_cap_value )
        elsif fo.isa.present? && funding_option_config_rate_cap.present? &&  top_rate_cap < @rate_cap_value
          UpdateAsync.perform_async('funding_option_config', funding_option_config_rate_cap.id , value: top_rate_cap )
        end
      end
    end
  end

  def payment_config_ids
    call_funding_options_by_country.map{|fo| fo.funding_opportunity.payment_config.id}.uniq
  end

  def update_payment_config
    PaymentConfig.where(id:payment_config_ids).each do |payment_config|
      UpdateAsync.perform_async('payment_config', payment_config.id , conciliation_rate: @rate_cap_value) unless payment_config.conciliation_rate < @rate_cap_value
      UpdateAsync.perform_async('payment_config', payment_config.id , normalization_rate: @rate_cap_value) unless payment_config.normalization_rate < @rate_cap_value
      UpdateAsync.perform_async('payment_config', payment_config.id , termination_rate: @rate_cap_value) unless payment_config.termination_rate < @rate_cap_value
      UpdateAsync.perform_async('payment_config', payment_config.id , arrears_rate: @rate_cap_value) unless payment_config.arrears_rate < @rate_cap_value
    end
  end

end