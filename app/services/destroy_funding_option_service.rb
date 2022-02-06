class DestroyFundingOptionService

  def self.for(funding_option_id)
    begin
      new(funding_option_id).perform
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def initialize(funding_option_id)
    @funding_option = FundingOption.find(funding_option_id)
  end


  def perform
    return if @funding_option.nil?
    
    if @funding_option.isa.nil?
      ModelingFlowFee.joins(modeling_flow_detail: [modeling_flow: :funding_option]).where('funding_options.id = ?',@funding_option.id).delete_all
      ModelingFlowExtra.joins(modeling_flow_detail: [modeling_flow: :funding_option]).where('funding_options.id = ?',@funding_option.id).delete_all
      ModelingFlowDetail.joins(modeling_flow: :funding_option).where('funding_options.id = ?',@funding_option.id).delete_all
      ModelingFlowSummary.joins(modeling_flow: :funding_option).where('funding_options.id = ?',@funding_option.id).delete_all
      ModelingFlow.joins(:funding_option).where('funding_options.id = ?',@funding_option.id).delete_all
      begin
        @funding_option.reload
        @funding_option.destroy
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end
  end
  
end