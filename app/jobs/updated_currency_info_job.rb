class UpdatedCurrencyInfoJob < ApplicationJob
  queue_as :worker

	def perform(*args)
		
		Country.all.each do |country|
			target_currencies = IncomeInformation.joins(user: [company: :country]).where('countries.id = ?',country.id).group(:currency).size.keys.compact
			target_currencies += ['USD','EUR','GBP','CAD','PEN','MXN','COP','CLP']
			target_currencies -= [country.currency]
			target_currencies.each do |currency|
				dowload_and_save_currencies(country.currency, currency, country)
			end
		end
  end

  def dowload_and_save_currencies base_currency, target_currency, country
		CurrenyHistory.get_and_save_exchange_rates(base_currency, target_currency)
		IncomeInformation.update_exchange_rates(target_currency, country)
  end
end

