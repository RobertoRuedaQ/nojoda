class ContractStatusCheckJob < ApplicationJob

  def perform(*args)
  	isas = Isa.select(:id).active
  	isas.each do |isa|
    	ModelClassesAsync.perform_async('Isa', 'save', isa.id)
    end
    FundingOption.select(:id).joins(:isa).where(isas: {id: isas.ids }).each do |funding_option|
    	ModelClassesAsync.perform_async('FundingOption', 'save', funding_option.id)
    end
  end
end
