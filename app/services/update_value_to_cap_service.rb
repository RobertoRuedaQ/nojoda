class UpdateValueToCapService
  def self.for(funding_option, evaluation_date)
    return unless funding_option.instance_of?(FundingOption)

    new(funding_option, evaluation_date).perform
  end

  def initialize(funding_option, evaluation_date)
    @funding_option = funding_option
    @evaluation_date = evaluation_date
    return if @evaluation_date.nil?
  end

  def perform
		begin
			temp_value_to_cap = @funding_option.value_to_cap_logic(@evaluation_date)
			@funding_option.update_column('value_to_cap',temp_value_to_cap)
			temp_value_to_cap_with_excess = @funding_option.value_to_cap_with_excess_logic(Time.now.to_date)
			@funding_option.update_column('value_to_cap_with_excess',temp_value_to_cap_with_excess.to_f)
			
		rescue Exception => e
			puts "failed to update value_to_cap for funding_option: #{@funding_option.id}"	
		end
  end
end