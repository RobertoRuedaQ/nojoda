class CurrenyHistory < ApplicationRecord
      
  resourcify
  audited

  def self.get_last_rate(base, target)
    last = self.where(currency_base: base, currency_target: target).order(date: :desc).first

    last.nil? ? self.get_and_save_exchange_rates(base, target) : last
  end

  def self.get_and_save_exchange_rates  base_currency, target_currency
    target_date = Time.zone.now.last_month.end_of_month
    currency = ExchangeRatesService.for(base_currency, target_currency, target_date)
		unless currency.empty?
			object = CurrenyHistory.find_or_create_by(currency)
    end

    return object || nil 
  end
end
