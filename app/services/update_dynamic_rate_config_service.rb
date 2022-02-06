class UpdateDynamicRateConfigService

  def self.for(isa_id)
    new(isa_id).perform
  end

  def initialize(isa_id)
    @isa = Isa.find(isa_id)
  end


  def perform
    begin
      if @isa.instance_of? Isa
        if out_of_fund_status
          if rate_cap_config.present?
            dynamic_rate_cap.update(other_value: 'false') unless dynamic_rate_cap.nil?
          end
        end
      end
    rescue StandardError => e
      return puts e
    end
  end

  private
   
  def out_of_fund_status
    ['active', 'manual_activation', 'recovered_from_default'].exclude?(@isa.stored_general_status)
  end

  def rate_cap_config
    @isa.funding_option.funding_option_config.select{|foc| foc.name == 'rate_cap'}.last
  end

  def dynamic_rate_cap
    @isa.funding_option.funding_option_config.select{|foc| foc.name == 'dynamic_rate_cap'}.last
  end

end