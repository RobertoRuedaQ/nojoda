module LumniFinance
	include Xirr

   def months_between start_date, end_date
    (end_date.to_date.year * 12 + end_date.to_date.month) - (start_date.to_date.year * 12 + start_date.to_date.month)
   end


	# The rate most be anual
	def amortization_payment present_value,rate,number_months, estimation_date, start_date
		present_value = present_value.to_f
		rate = rate.to_f
		number_months = number_months.to_i
		estimation_date = estimation_date.to_date
		start_date = start_date.to_date

		r = rate.to_f / 100
		monthly_rate = (1 + r)**(1.to_f / 12) - 1

		if monthly_rate == 0
			result = present_value / number_months.to_f
		else
			adjustment_start = [months_between(estimation_date, start_date) - 1,0].max
			inicial_value = present_value*(1 + monthly_rate)**(adjustment_start)
			result = inicial_value * (monthly_rate * (1 + monthly_rate)**(number_months))/((1 + monthly_rate)**(number_months) - 1)
		end
		return result.to_f.round(1)
	end


	def lumni_xnpv target_hash, annual_rate
		monthly_rate = (1+ annual_rate.to_f)**(1/12.to_f) - 1
		min_date = target_hash.keys.min.beginning_of_month
		present_value = 0
		target_hash.each do |date,value|
			present_value += value/(1+ monthly_rate)**(months_between(min_date,date))
			puts "#{date.to_s},#{value},#{months_between(min_date,date)},#{value/(1+ monthly_rate)**(months_between(min_date,date))},#{min_date},#{monthly_rate}"
		end
		present_value.to_f.round(1)
	end

	def lumni_future_value present_value, monthly_rate, start_date, end_date
		(present_value*(1 + monthly_rate)**months_between(start_date,end_date)).floor(2).to_f
	end

	def lumni_xirr(target_hash)
		flow = []
		target_hash.each do |date, value|
		flow << Xirr::Transaction.new(value,  date: date.to_date)
		end
		cf = Xirr::Cashflow.new(flow: flow)
		cf.xirr.to_f * 100
	end

end


